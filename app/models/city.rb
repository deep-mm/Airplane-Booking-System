class City < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :flights, dependent: :destroy, :foreign_key => "origin_city_id", :class_name => "Flight"
  has_many :flights, dependent: :destroy, :foreign_key => "destination_city_id", :class_name => "Flight"
end
