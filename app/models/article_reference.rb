class ArticleReference < ApplicationRecord
  validates :article,
    uniqueness: { message: "Этот артикул уже занят" },
    presence: { message: "Укажите артикул" }

  validates :name,
    presence: { message: "Укажите наименование" }
end
