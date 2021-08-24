class Article < ApplicationRecord
  belongs_to :user
  validates :title, presence: true,
            length: { minimum:3, maximum: 30 }
  validates :description, presence: true
end