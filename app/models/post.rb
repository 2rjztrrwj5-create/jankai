class Post < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true
  validates :event_at, presence: true
  validates :capacity, presence: true
  enum :format, { offline: 0, online: 1 }
end
