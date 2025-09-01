class MedicalUnitsController < ApplicationController
  before_action :set_medical_unit, only: [:show, :edit, :update, :destroy]

  def index
    @medical_units = MedicalUnit.all
  end

  def show
  end

  def new
    @medical_unit = MedicalUnit.new
  end

  def create
    @medical_unit = MedicalUnit.new(medical_unit_params)
    if @medical_unit.save
      redirect_to @medical_unit, notice: "Medical unit was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @medical_unit.update(medical_unit_params)
      redirect_to @medical_unit, notice: "Medical unit was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @medical_unit.destroy
    redirect_to medical_units_path, notice: "Medical unit was successfully deleted."
  end

  private

  def set_medical_unit
    @medical_unit = MedicalUnit.find(params[:id])
  end

  def medical_unit_params
    params.require(:medical_unit).permit(:name, :unit_type, :phone_number)
  end
end
