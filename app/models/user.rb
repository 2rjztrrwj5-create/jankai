class User < ApplicationRecord
  has_secure_password
  validates :password, length: { minimum: 6 }, allow_nil: true
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :email_address, presence: true, uniqueness: true

  validates :name, presence: true
  has_many :posts, dependent: :destroy

  has_many :comments, dependent: :destroy

  has_many :group_members, dependent: :destroy
  has_many :groups, through: :group_members
  has_many :applications, dependent: :destroy
end
