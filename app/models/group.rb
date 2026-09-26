class Group < ApplicationRecord
  validates :name, presence: true
  has_many :group_members, dependent: :destroy
  has_many :users, through: :group_members
  belongs_to :post
  has_many :comments, as: :commentable, dependent: :destroy
end