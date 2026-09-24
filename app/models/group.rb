class Group < ApplicationRecord
  validates :name, presence: true
  has_many :group_members, dependent: :destroy
  has_many :users, through: :group_members
  has_many :applications, dependent: :destroy
  belongs_to :post
end