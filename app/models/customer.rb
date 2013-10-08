class Customer < ActiveRecord::Base

  has_many :tour_requests, dependent: :destroy

  validates :email, :email_format => { message: "Please enter a valid email address." }
  validates_presence_of :first_name, on: :update, :message => "Please enter your first name."
  validates_presence_of :last_name,  on: :update, :message => "Please enter your last name."
  validates_format_of :phone_number, on: :update,
                      :with => /\(?[0-9]{3}\)?-[0-9]{3}-[0-9]{4}/,
                      :message => "Phone numbers must be in xxx-xxx-xxxx format."

  attr_accessible :first_name, :last_name, :phone_number

end