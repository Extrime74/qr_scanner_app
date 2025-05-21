class CreateScanRecords < ActiveRecord::Migration[8.0]
  def change
    create_table :scan_records do |t|
      t.string :qr_code
      t.string :consignee
      t.string :apzgr_number
      t.string :box_number
      t.string :article
      t.string :size
      t.integer :quantity

      t.timestamps
    end
  end
end
