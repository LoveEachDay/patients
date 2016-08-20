class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]
  before_action :is_patient_deleted, only: [:show, :edit, :update, :destroy]
  before_action :increment_view_count, only: [:show]

  # GET /patients
  # GET /patients.json
  def index
    if params[:set_locale]
      redirect_to patients_url(locale: params[:set_locale])
    else
      @patients = Patient.not_deleted
    end
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
  end

  # GET /patients/new
  def new
    @patient = Patient.new
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients
  # POST /patients.json
  def create
    @patient = Patient.new(patient_params)

    respond_to do |format|
      if @patient.save
        format.html { redirect_to @patient, notice: I18n.t('patient_creation_succeed') }
        format.json { render :show, status: :created, location: @patient }
      else
        format.html { render :new }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to @patient, notice: I18n.t('patient_update_succeed') }
        format.json { render :show, status: :ok, location: @patient }
      else
        format.html { render :edit }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    @patient.update_attributes(deleted: true)
    respond_to do |format|
      format.html { redirect_to patients_url, notice: I18n.t('patient_marked_delete') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    def is_patient_deleted
      if @patient.deleted?
        redirect_to patients_url and return false
      end
    end

    def increment_view_count
      Patient.increment_counter(:view_count, @patient)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_params
      params.require(:patient).permit(:first_name, :middle_name, :last_name, :date_of_birth, :gender, :status, :location_id, :view_count, :deleted)
    end
end
