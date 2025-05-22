require "axlsx"

class ScanRecordsController < ApplicationController
  before_action :set_scan_record, only: %i[ show edit update destroy ]

  # GET /scan_records or /scan_records.json
  def index
    @start_date = params[:start_date]
    @end_date = params[:end_date]

    @scan_records = ScanRecord.all

    if @start_date.present? && @end_date.present?
      begin
        start_dt = Date.parse(@start_date).beginning_of_day
        end_dt = Date.parse(@end_date).end_of_day
        @scan_records = @scan_records.where(created_at: start_dt..end_dt)
      rescue ArgumentError
        flash.now[:alert] = "Неверный формат даты"
      end
    end
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
    Rails.logger.info "QR string received: #{qr_string.inspect}"

    if qr_string.present?
      parts = qr_string.split("?")
      Rails.logger.info "Split parts: #{parts.inspect}"

      if parts.size < 2
        render json: { error: "Неверный формат QR-кода" }, status: :unprocessable_entity
        return
      end

      qr_code_id = parts[0]
      qr_code_text = qr_string

      if ScanRecord.exists?(qr_code_id: qr_code_id)
        render json: { message: "QR-код был считан ранее." }, status: :conflict
        return
      end

      scan_record = ScanRecord.new(qr_code_id: qr_code_id, qr_code_text: qr_code_text)
      Rails.logger.info "Saving ScanRecord: #{scan_record.inspect}"

      if scan_record.save
        render json: { message: "QR-код считан." }, status: :created
      else
        Rails.logger.error "Errors saving ScanRecord: #{scan_record.errors.full_messages}"
        render json: { errors: scan_record.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "QR-данные не переданы." }, status: :bad_request
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

  # def export
  #  @scan_records = ScanRecord.all
  #
  #    package = Axlsx::Package.new
  #    workbook = package.workbook
  #    workbook.add_worksheet(name: "Сканы") do |sheet|
  #      sheet.add_row [ "ID", "QR код", "Грузополучатель", "Номер АПЗГР", "Номер короба", "Артикул", "Размер", "Количество" ]
  #      @scan_records.each do |record|
  #        sheet.add_row [
  #          record.id, record.qr_code, record.consignee,
  #          record.apzgr_number, record.box_number,
  #          record.article, record.size, record.quantity
  #        ]
  #      end
  #    end
  #
  #    send_data package.to_stream.read, type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
  #                                      filename: "scan_records.xlsx"
  #  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scan_record
      @scan_record = ScanRecord.find(params[:id])
    end

    def scan_record_params
      params.require(:scan_record).permit(:qr_code_id, :qr_code_text)
    end
end
