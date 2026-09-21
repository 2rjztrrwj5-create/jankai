class Group < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  has_many :group_members, dependent: :destroy
  has_many :users, through: :group_members
end