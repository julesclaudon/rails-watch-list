class Bookmark < ApplicationRecord
  has_one_attached :photo
  belongs_to :movie
  belongs_to :list
  validates :comment, length: { minimum: 6 }
  validates :list, uniqueness: { scope: :movie }
end
