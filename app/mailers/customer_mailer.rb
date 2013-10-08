class CustomerMailer < ActionMailer::Base
  default from: Rails.application.config.support_email

  def initial_email(customer)
    @initial_url = Rails.application.config.initial_request_url
    @customer = customer

    mail(to: customer.email, subject: 'Tour Request from Tours Du Jour')
  end

  def confirm_email(tour_request)
    @tour_request = tour_request

    mail(to: tour_request.customer.email, subject: 'Tour Scheduled with Tours Du Jour')
  end
end