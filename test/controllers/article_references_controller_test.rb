require "test_helper"

class ArticleReferencesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article_reference = article_references(:one)
  end

  test "should get index" do
    get article_references_url
    assert_response :success
  end

  test "should get new" do
    get new_article_reference_url
    assert_response :success
  end

  test "should create article_reference" do
    assert_difference("ArticleReference.count") do
      post article_references_url, params: { article_reference: { article: @article_reference.article, name: @article_reference.name } }
    end

    assert_redirected_to article_reference_url(ArticleReference.last)
  end

  test "should show article_reference" do
    get article_reference_url(@article_reference)
    assert_response :success
  end

  test "should get edit" do
    get edit_article_reference_url(@article_reference)
    assert_response :success
  end

  test "should update article_reference" do
    patch article_reference_url(@article_reference), params: { article_reference: { article: @article_reference.article, name: @article_reference.name } }
    assert_redirected_to article_reference_url(@article_reference)
  end

  test "should destroy article_reference" do
    assert_difference("ArticleReference.count", -1) do
      delete article_reference_url(@article_reference)
    end

    assert_redirected_to article_references_url
  end
end
