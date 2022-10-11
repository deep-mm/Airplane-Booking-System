class Reservation < ApplicationRecord
  validates :passengers, presence: true ,numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :reservation_class, presence: true, inclusion: { in: %w(first business economy),
                                                 message: "%{value} is not a valid class" }
  validates :amenities, presence: true, inclusion: { in: %w(none wifi meal_preference extra_legroom),
                                                     message: "%{value} is not a valid amenity" }
  validates :cost, presence: true, numericality: true
  has_one :flight
  belongs_to :user
  has_many :baggages , dependent: :destroy
end