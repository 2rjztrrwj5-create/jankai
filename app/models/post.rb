class Post < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true
  validates :event_at, presence: true
  validates :capacity, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :prefecture, presence: true, if: -> { format == "offline" }
  validates :prefecture, format: { without: /[a-zA-Z]/, message: "にはアルファベットを含めないでください" }
  enum :format, { offline: 0, online: 1 }
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :applications, dependent: :destroy
  has_one :group, dependent: :destroy
end
