json.extract! scan_record, :id, :qr_code, :consignee, :apzgr_number, :box_number, :article, :size, :quantity, :created_at, :updated_at
json.url scan_record_url(scan_record, format: :json)
