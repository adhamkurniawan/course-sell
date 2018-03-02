class Task < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :course

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, :video_url, :image, presence: true
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
