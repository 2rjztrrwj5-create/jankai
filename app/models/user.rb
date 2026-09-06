class User < ApplicationRecord
  has_secure_password
  validates :password, length: { minimum: 6 }, allow_nil: true
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :name, presence: true
end
