class Admin < ApplicationRecord
  has_secure_password
  validates :password, length: { minimum: 6 }, allow_nil: true
  has_many :admin_sessions, dependent: :destroy
end
