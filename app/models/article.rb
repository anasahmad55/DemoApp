class Article < ApplicationRecord
  has_many :article_categories
  has_many :categories, through: :article_categories
  belongs_to :user
  validates :title, presence: true,
            length: { minimum:3, maximum: 30 }
  validates :description, presence: true
end