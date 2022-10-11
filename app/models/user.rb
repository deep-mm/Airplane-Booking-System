class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :credit_card, format: { with: /\A(\d{4}-\d{4}-\d{4}-\d{4})\z/, message: "Enter 16 digit separated by '-' " }, length: { is: 19 }, allow_nil: true, allow_blank: true
  validates :mobile, length: { is: 10 }, allow_nil: true, allow_blank: true
  validates :email, email: true
  has_many :reservations, dependent: :delete_all
end
