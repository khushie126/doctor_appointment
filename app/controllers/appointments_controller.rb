class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy, :change_status]

  def index
    @appointments = Appointment.all
  end

  def show
  end

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.booking_number = SecureRandom.random_number(10**8)

    if @appointment.save
      redirect_to @appointment, notice: "Appointment was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @appointment.update(appointment_params)
      redirect_to @appointment, notice: "Appointment was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @appointment.destroy
    redirect_to appointments_path, notice: "Appointment was successfully deleted."
  end

  def change_status
    if current_user&.role == "doctor"
      if @appointment.update(status: params[:status])
        redirect_to @appointment, notice: "Status updated successfully."
      else
        redirect_to @appointment, alert: "Failed to update status."
      end
    else
      redirect_to appointments_path, alert: "Unauthorized access."
    end
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:start_time, :status, :description, :patient_id, :doctor_id, :location_id)
  end
end
