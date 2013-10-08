class CustomerInteractionController < ApplicationController

  # Common use method for pulling customer from the db with guid from URL or session.
  def retrieve_customer
    customer = Customer.find_by_guid((params.has_key?(:customer_id)) ? params[:customer_id] : session[:customer_id])

    if customer == nil
      flash[:notice] = 'We are sorry, but we cannot find any records indicating that you have started the request process.
                          Please provide us with your email address so we can contact you.'

      redirect_to :action => 'index'
    else
      session[:customer_id] = customer.guid
    end
    customer
  end

end