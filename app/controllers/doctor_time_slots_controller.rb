class DoctorTimeSlotsController < ApplicationController
  before_action :set_time_slot, only: [:show, :edit, :update, :destroy]

  def index
    @slots = DoctorTimeSlot.all
  end

  def show
  end

  def new
    @slot = DoctorTimeSlot.new
  end

  def create
    @slot = DoctorTimeSlot.new(time_slot_params)
    if @slot.save
      redirect_to @slot, notice: "Doctor time slot was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @slot.update(time_slot_params)
      redirect_to @slot, notice: "Doctor time slot was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @slot.destroy
    redirect_to doctor_time_slots_path, notice: "Doctor time slot was successfully deleted."
  end

  private

  def set_time_slot
    @slot = DoctorTimeSlot.find(params[:id])
  end

  def time_slot_params
    params.require(:doctor_time_slot).permit(:doctor_id, :start_time, :end_time, :date, :location_id)
  end
end
