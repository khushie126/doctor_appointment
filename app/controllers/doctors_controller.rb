class DoctorsController < ApplicationController
  before_action :set_doctor, only: [:show, :edit, :update, :destroy]

  def index
    @doctors = Doctor.all.includes(:specializations, :medical_unit)
  end

  def show
  end

  def new
    @doctor = Doctor.new
  end

  def create
    @doctor = Doctor.new(doctor_params)
    if @doctor.save
      redirect_to @doctor, notice: "Doctor was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @doctor.update(doctor_params)
      redirect_to @doctor, notice: "Doctor was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @doctor.destroy
    redirect_to doctors_path, notice: "Doctor was successfully deleted."
  end

  private

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end

  def doctor_params
    params.require(:doctor).permit(:phone_number, :image, :medical_unit_id, specialization_ids: [])
  end
end
