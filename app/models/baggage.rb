class Baggage < ApplicationRecord
  validates :weight, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :cost, presence: true, numericality: true
  belongs_to :reservation
end