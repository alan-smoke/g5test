class TourRequestController < CustomerInteractionController

  # Displaying page to collect email address.
  def index
    @page_title = 'Initialize Tour Request'
  end

  # Taking email and sending initialization link
  def send_initial_email
    @page_title = 'Email Sent'

    customer = Customer.new
    customer.email = params[:email_address]
    customer.guid = SecureRandom.uuid()

    if !customer.save
      flash.now[:errors] = customer.errors
      @email = customer.email
      render :action => 'index'
    else
      begin
        CustomerMailer.initial_email(customer).deliver
      rescue => exception
        email_error(exception, customer.email)
      end
    end
  end

  # First page of process to get customer info.
  def start_tour_request
    @page_title = 'Personal Info'

    @customer = retrieve_customer
    if @customer != nil && @customer.tour_requests.count > 0
      redirect_to :controller => 'tour_rating', :action => 'tour_rating'
    end
  end

  # Saving customer info and displaying tour info entry page.
  def tour_info
    @page_title = 'Tour Info'

    @customer = retrieve_customer
    if @customer != nil
      @customer.ip_address = request.remote_ip
      if !@customer.update_attributes(params[:customer])
        flash.now[:errors] = @customer.errors
        render :action => 'start_tour_request'
      end

      @tour_request = TourRequest.new
      @amenities = Amenity.all
    end
  end

  # Final step of creating a request.  Saves the full request, and displays a success page
  def create_request
    @page_title = 'Created Tour Request'

    @customer = retrieve_customer
    if @customer != nil

      # Handling back button or refresh
      if @customer.tour_requests != nil && @customer.tour_requests.count > 0
        render 'duplicate_request', :layout => true
        # Wish there was a way to return out of this instead of using if blocks.
      else
        @tour_request = TourRequest.new(params[:tour_request])
        @tour_request.customer = @customer
        if params[:amenity_ids] != nil  # User is not required to select an amenity
          @tour_request.amenities = Amenity.find(params[:amenity_ids])
        end

        # Saving and error handling
        if !@tour_request.save
          flash.now[:errors] = @tour_request.errors
          @amenities = Amenity.all
          render :action => 'tour_info'
        else
          begin
            CustomerMailer.confirm_email(@tour_request).deliver
            SupportMailer.new_tour_request_email(@tour_request).deliver
          rescue => exception
            email_error(exception, @tour_request.customer.email)
          end
        end
      end
    end

  end

  private
  def email_error(exception, email)
    logger.error(exception.message)
    flash.now[:errors] = {'key' => ['There was a problem delivering your email.  Please contact ' + Rails.application.config.support_email]}
    @email = email
    render :action => 'index'
  end

end