class Api::V1::DoctorsController < ApplicationController
      before_action :set_doctor, only: [:show, :update, :destroy]
     
      def index
        @doctors = Doctor.all.includes(:specializations, :medical_unit)
        render json: @doctors.to_json(include: [:specializations, :medical_unit])
      end

      def show
        render json: @doctor.to_json(include: [:specializations, :medical_unit])
      end

      def create
        @doctor = Doctor.new(doctor_params)
        if @doctor.save
          render json: @doctor, status: :created
        else
          render json: @doctor.errors, status: :unprocessable_entity
        end
      end

      def update
        if @doctor.update(doctor_params)
          render json: @doctor
        else
          render json: @doctor.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @doctor.destroy
        head :no_content
      end

      private

      def set_doctor
        @doctor = Doctor.find(params[:id])
      end

      def doctor_params
        params.permit(:phone_number, :image, :medical_unit_id, specialization_ids: [])
      end
    end

