class Api::V1::MedicalUnitsController < ApplicationController
  def index
    @medical_units = MedicalUnit.all
    render json: @medical_units
  end
  def show 
    @medical_unit = MedicalUnit.find(params[:id])
    render json: @medical_unit
  end
  def new
    @medical_unit = MedicalUnit.new(medical_unit_params)
    if @medical_unit.save
      render json: @medical_unit
    else
      render json: { errors: @medical_unit.errors.full_messages }, status: :unprocessable_entity
    end
  end
  private
  def medical_unit_params
    params.require(:medical_unit).permit( :name, :type, :phone_number)
  end
end
