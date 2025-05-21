class CreateArticleReferences < ActiveRecord::Migration[8.0]
  def change
    create_table :article_references do |t|
      t.string :article
      t.string :name

      t.timestamps
    end
  end
end
