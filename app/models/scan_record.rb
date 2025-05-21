# app/models/scan_record.rb
class ScanRecord < ApplicationRecord
validates :qr_code_id, uniqueness: true

  def parsed_qr_data
    return {} unless qr_code_text.present?

    parts = qr_code_text.split("?")
    return {} if parts.size < 7

    raw_sizes = parts[6].strip

    size_entries = raw_sizes.split(/\s*,\s*/)

    parsed_sizes = size_entries.map do |entry|
      # Удаляем "ед." и разбираем
      cleaned_entry = entry.strip.sub(" ед.", "")

      if cleaned_entry =~ /(.*?)-(\d+)\z/
        size = $1.strip
        quantity = $2.strip
        { size: size, quantity: quantity }
      else
        { size: cleaned_entry, quantity: "" }
      end
    end

    {
      consignee: parts[1],
      apzgr: parts[2],
      box_number: parts[3],
      article: parts[4],
      sizes_with_quantities: parsed_sizes
    }
  end
end
