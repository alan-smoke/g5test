class SupportMailer < ActionMailer::Base
  default from: Rails.application.config.support_email

  def new_tour_request_email(tour_request)
    @tour_request = tour_request

    mail(to: Rails.application.config.support_email, subject: 'Tour Scheduled')
  end
end