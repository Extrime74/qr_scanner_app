require "test_helper"

class ScanRecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @scan_record = scan_records(:one)
  end

  test "should get index" do
    get scan_records_url
    assert_response :success
  end

  test "should get new" do
    get new_scan_record_url
    assert_response :success
  end

  test "should create scan_record" do
    assert_difference("ScanRecord.count") do
      post scan_records_url, params: { scan_record: { apzgr_number: @scan_record.apzgr_number, article: @scan_record.article, box_number: @scan_record.box_number, consignee: @scan_record.consignee, qr_code: @scan_record.qr_code, quantity: @scan_record.quantity, size: @scan_record.size } }
    end

    assert_redirected_to scan_record_url(ScanRecord.last)
  end

  test "should show scan_record" do
    get scan_record_url(@scan_record)
    assert_response :success
  end

  test "should get edit" do
    get edit_scan_record_url(@scan_record)
    assert_response :success
  end

  test "should update scan_record" do
    patch scan_record_url(@scan_record), params: { scan_record: { apzgr_number: @scan_record.apzgr_number, article: @scan_record.article, box_number: @scan_record.box_number, consignee: @scan_record.consignee, qr_code: @scan_record.qr_code, quantity: @scan_record.quantity, size: @scan_record.size } }
    assert_redirected_to scan_record_url(@scan_record)
  end

  test "should destroy scan_record" do
    assert_difference("ScanRecord.count", -1) do
      delete scan_record_url(@scan_record)
    end

    assert_redirected_to scan_records_url
  end
end
