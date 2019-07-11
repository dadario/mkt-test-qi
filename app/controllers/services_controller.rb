# frozen_string_literal: true

class ServicesController < ApplicationController
  before_action :set_service, only: %i[show edit update destroy execute]
  skip_before_action :verify_authenticity_token, only: :requested

  # GET /services
  # GET /services.json
  def index
    @services = Service.all
  end

  # GET /services/1
  # GET /services/1.json
  def show; end

  # GET /services/new
  def new
    @service = Service.new
  end

  # GET /services/1/edit
  def edit; end

  # POST /services
  # POST /services.json
  def create
    @service = Service.new(service_params)

    respond_to do |format|
      if @service.save
        format.html { redirect_to services_url, notice: 'Service was successfully created.' }
        format.json { render :show, status: :created, location: @service }
      else
        format.html { render :new }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /services/requested
  # POST /services/requested.json
  def requested
    requested_params = {
      external_code: params[:id],
      company_name: params[:company][:name],
      recruiter_name: params[:recruiter][:name],
      applicant_name: params[:applicant][:name],
      job_id: params[:job][:id],
      job_title: params[:job][:title],
      status: params[:status]
    }

    @service = Service.new(requested_params)

    if @service.save
      render json: { status: :created }, status: :created
    else
      render json: @service.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /services/1
  # PATCH/PUT /services/1.json
  def update
    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to services_url, notice: 'Service was successfully updated.' }
        format.json { render :show, status: :ok, location: @service }
      else
        format.html { render :edit }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    @service.destroy
    respond_to do |format|
      format.html { redirect_to services_url, notice: 'Service was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /services/1/execute
  def execute
    @service.send_message
    respond_to do |format|
      format.html { redirect_to services_url, notice: 'Service was successfully executed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_service
    @service = Service.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def service_params
    params.require(:service).permit(:external_code,
                                    :company_name,
                                    :recruiter_name,
                                    :applicant_name,
                                    :job_id,
                                    :job_title)
  end
end
