class ArticleReference < ApplicationRecord
  validates :article, presence: true, uniqueness: true
  validates :name, presence: true
end
