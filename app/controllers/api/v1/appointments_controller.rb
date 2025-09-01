class Api::V1::AppointmentsController < ApplicationController
      before_action :set_appointment, only: [ :show, :update, :destroy, :change_status ]
      def index
        @appointments = Appointment.all
        render json: @appointments
      end


      def show
        render json: @appointment
      end

      def create
        @appointment = Appointment.new(appointment_params)
        @appointment.booking_number = SecureRandom.random_number(10**8)
        if @appointment.save
          render json: @appointment, status: :created
        else
          render json: @appointment.errors, status: :unprocessable_entity
        end
      end

      def update
        if @appointment.update(appointment_params)
          render json: @appointment
        else
          render json: @appointment.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @appointment.destroy
        head :no_content
      end

      def change_status
        if current_user&.role == "doctor"
          if @appointment.update(status: params[:status])
            render json: @appointment
          else
            render json: @appointment.errors, status: :unprocessable_entity
          end
        else
          render json: { error: "Unauthorized" }, status: :unauthorized
        end
      end

      private

      def set_appointment
        @appointment = Appointment.find(params[:id])
      end

      def appointment_params
        params.permit(:start_time,:status, :description, :patient_id, :doctor_id, :location_id)
      end
end
