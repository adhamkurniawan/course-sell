class Course < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :tasks, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true
  validates :price, presence: true, numericality: { only_integer: true }

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def average_rating
    reviews.blank? ? 0 : reviews.average(:star).round(2)
  end
end
