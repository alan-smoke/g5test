class TourRatingController < CustomerInteractionController

  # Display a rating selection with the tour info.
  def tour_rating
    @page_title = 'Rate Your Tour'

    @customer = retrieve_customer
    if @customer != nil
      @tour_request = @customer.tour_requests.first   # Assuming one tour per customer.  Will have to be modified if more than one tour per customer is allowed.
      if @tour_request.tour_rating != nil
        render 'duplicate_rating', :layout => true
      end
    end
  end

  # User selects a rating and is given a success message
  def create_rating
    @page_title = 'Rating Submitted'

    @customer = retrieve_customer
    if @customer != nil
      @tour_request = @customer.tour_requests.first
      if @tour_request.tour_rating != nil     # Handling back button or refresh
        render 'duplicate_rating', :layout => true
      else
        tour_rating = TourRating.new
        tour_rating.rating = params[:rating]
        tour_rating.tour_request_id = @tour_request.id    # Had to assign this way to be able to validate rating field with TourRating model.

        if !tour_rating.save
          flash.now[:errors] = tour_rating.errors
          render :action => 'tour_rating'
        end
      end
    end
  end

end