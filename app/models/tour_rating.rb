class TourRating < ActiveRecord::Base

  belongs_to :tour_request

  validates_numericality_of :rating, :message => 'Please select a rating.'

  attr_accessible :rating

end