class TourRequest < ActiveRecord::Base

  belongs_to :customer
  has_one :tour_rating
  has_and_belongs_to_many :amenities

  validates_date :tour_date, :on_or_after => :today, :on_or_after_message => "Please enter a tour date on or after today.",
                    :message => "Please enter a valid tour date."

  attr_accessible :tour_date, :additional_questions

end