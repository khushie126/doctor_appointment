class Api::V1::DoctorTimeSlotsController < ApplicationController
      before_action :set_time_slot, only: [:show, :update, :destroy]

      def index
        @slots = DoctorTimeSlot.all
        render json: @slots
      end

      def show
        render json: @slot
      end

      def create
        @slot = DoctorTimeSlot.new(time_slot_params)
        if @slot.save
          render json: @slot, status: :created
        else
          render json: @slot.errors, status: :unprocessable_entity
        end
      end

      def update
        if @slot.update(time_slot_params)
          render json: @slot
        else
          render json: @slot.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @slot.destroy
        head :no_content
      end

      private

      def set_time_slot
        @slot = DoctorTimeSlot.find(params[:id])
      end

      def time_slot_params
        params.require(:doctor_time_slot).permit(:doctor_id, :start_time, :end_time, :date, :location_id)
      end
    end

