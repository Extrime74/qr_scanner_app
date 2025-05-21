class ScanRecord < ApplicationRecord
  validates :qr_code, uniqueness: true
end
