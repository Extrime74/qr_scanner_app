class UpdateScanRecordsStructure < ActiveRecord::Migration[7.1]
  def change
    change_table :scan_records do |t|
      # Удаляем старые столбцы
      t.remove :qr_code, :consignee, :apzgr_number, :box_number, :article, :size, :quantity

      # Добавляем новые столбцы
      t.string :qr_code_id
      t.text :qr_code_text
    end
  end
end
