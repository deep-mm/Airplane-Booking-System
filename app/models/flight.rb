class Flight < ApplicationRecord
  validates :name, presence: true
  validates :flight_class, inclusion: { in: %w(jumbo private small),
                                 message: "%{value} is not a valid class" }, presence: true
  validates :manufacturer, presence: true
  validates :capacity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :status, presence: true, inclusion: { in: %w(available complete),
                                                  message: "%{value} is not a valid status" }
  validates :cost, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :origin_city_id, presence: true
  validates :destination_city_id, presence: true
  validate :valid_trip

  has_many :reservations, dependent: :destroy
  belongs_to :origin_cities ,:foreign_key => "origin_city_id", :class_name => "City"
  belongs_to :destination_cities ,:foreign_key => "destination_city_id", :class_name => "City"

  private
  def valid_trip
    if origin_city_id == nil || destination_city_id == nil
      errors.add("City ID", ': Origin or Destination City cannot be empty')
    elsif origin_city_id == destination_city_id
      errors.add(City.find(origin_city_id).name, ': Origin and Destination City cannot be same')
    end
  end
end