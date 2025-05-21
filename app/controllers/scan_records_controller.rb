require "axlsx"

class ScanRecordsController < ApplicationController
  before_action :set_scan_record, only: %i[ show edit update destroy ]

  # GET /scan_records or /scan_records.json
  def index
    @scan_records = ScanRecord.all
  end

  # GET /scan_records/1 or /scan_records/1.json
  def show
  end

  # GET /scan_records/new
  def new
    @scan_record = ScanRecord.new
  end

  # GET /scan_records/1/edit
  def edit
  end

  # POST /scan_records or /scan_records.json
  def create
    qr_string = params[:qr_data]

    if qr_string.present?
      # Проверяем, есть ли запись с таким qr_code
      if ScanRecord.exists?(qr_code: qr_string)
        render json: { message: "Этот QR-код уже был добавлен." }, status: :conflict
        return
      end

      parts = qr_string.split("?")

      scan_record = ScanRecord.new(
        qr_code: qr_string,
        consignee: parts[0],
        apzgr_number: parts[1],
        box_number: parts[2],
        article: parts[3],
        quantity: parts[4],
        size: parts[5]
      )

      if scan_record.save
        render json: { message: "QR-код успешно добавлен." }, status: :created
      else
        render json: { errors: scan_record.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "No QR data provided" }, status: :bad_request
    end
  end

  # PATCH/PUT /scan_records/1 or /scan_records/1.json
  def update
    respond_to do |format|
      if @scan_record.update(scan_record_params)
        format.html { redirect_to @scan_record, notice: "Scan record was successfully updated." }
        format.json { render :show, status: :ok, location: @scan_record }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @scan_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scan_records/1 or /scan_records/1.json
  def destroy
    @scan_record.destroy!

    respond_to do |format|
      format.html { redirect_to scan_records_path, status: :see_other, notice: "Scan record was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def export
    @scan_records = ScanRecord.all

    package = Axlsx::Package.new
    workbook = package.workbook
    workbook.add_worksheet(name: "Сканы") do |sheet|
      sheet.add_row [ "ID", "QR код", "Грузополучатель", "Номер АПЗГР", "Номер короба", "Артикул", "Размер", "Количество" ]
      @scan_records.each do |record|
        sheet.add_row [
          record.id, record.qr_code, record.consignee,
          record.apzgr_number, record.box_number,
          record.article, record.size, record.quantity
        ]
      end
    end

    send_data package.to_stream.read, type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                                      filename: "scan_records.xlsx"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scan_record
      @scan_record = ScanRecord.find(params[:id])
    end

    def scan_record_params
      params.require(:scan_record).permit(:qr_code, :consignee, :apzgr_number, :box_number, :article, :size, :quantity)
    end
end
