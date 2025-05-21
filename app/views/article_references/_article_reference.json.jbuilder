json.extract! article_reference, :id, :article, :name, :created_at, :updated_at
json.url article_reference_url(article_reference, format: :json)
