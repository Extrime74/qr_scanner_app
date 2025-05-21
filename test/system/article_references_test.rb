require "application_system_test_case"

class ArticleReferencesTest < ApplicationSystemTestCase
  setup do
    @article_reference = article_references(:one)
  end

  test "visiting the index" do
    visit article_references_url
    assert_selector "h1", text: "Article references"
  end

  test "should create article reference" do
    visit article_references_url
    click_on "New article reference"

    fill_in "Article", with: @article_reference.article
    fill_in "Name", with: @article_reference.name
    click_on "Create Article reference"

    assert_text "Article reference was successfully created"
    click_on "Back"
  end

  test "should update Article reference" do
    visit article_reference_url(@article_reference)
    click_on "Edit this article reference", match: :first

    fill_in "Article", with: @article_reference.article
    fill_in "Name", with: @article_reference.name
    click_on "Update Article reference"

    assert_text "Article reference was successfully updated"
    click_on "Back"
  end

  test "should destroy Article reference" do
    visit article_reference_url(@article_reference)
    click_on "Destroy this article reference", match: :first

    assert_text "Article reference was successfully destroyed"
  end
end
