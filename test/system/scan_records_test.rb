require "application_system_test_case"

class ScanRecordsTest < ApplicationSystemTestCase
  setup do
    @scan_record = scan_records(:one)
  end

  test "visiting the index" do
    visit scan_records_url
    assert_selector "h1", text: "Scan records"
  end

  test "should create scan record" do
    visit scan_records_url
    click_on "New scan record"

    fill_in "Apzgr number", with: @scan_record.apzgr_number
    fill_in "Article", with: @scan_record.article
    fill_in "Box number", with: @scan_record.box_number
    fill_in "Consignee", with: @scan_record.consignee
    fill_in "Qr code", with: @scan_record.qr_code
    fill_in "Quantity", with: @scan_record.quantity
    fill_in "Size", with: @scan_record.size
    click_on "Create Scan record"

    assert_text "Scan record was successfully created"
    click_on "Back"
  end

  test "should update Scan record" do
    visit scan_record_url(@scan_record)
    click_on "Edit this scan record", match: :first

    fill_in "Apzgr number", with: @scan_record.apzgr_number
    fill_in "Article", with: @scan_record.article
    fill_in "Box number", with: @scan_record.box_number
    fill_in "Consignee", with: @scan_record.consignee
    fill_in "Qr code", with: @scan_record.qr_code
    fill_in "Quantity", with: @scan_record.quantity
    fill_in "Size", with: @scan_record.size
    click_on "Update Scan record"

    assert_text "Scan record was successfully updated"
    click_on "Back"
  end

  test "should destroy Scan record" do
    visit scan_record_url(@scan_record)
    click_on "Destroy this scan record", match: :first

    assert_text "Scan record was successfully destroyed"
  end
end
