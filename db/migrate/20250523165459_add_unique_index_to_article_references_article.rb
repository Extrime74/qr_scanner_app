class AddUniqueIndexToArticleReferencesArticle < ActiveRecord::Migration[6.1]
  def change
    unless index_exists?(:article_references, :article, unique: true, name: "index_article_references_on_article")
      add_index :article_references, :article, unique: true, name: "index_article_references_on_article"
    end
  end
end
