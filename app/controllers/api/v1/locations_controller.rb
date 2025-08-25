class Api::V1::LocationsController < ApplicationController
  
      before_action :set_location, only: [:show, :update, :destroy]

      def index
        @locations = Location.all.includes(:medical_unit)
        render json: @locations.to_json(include: :medical_unit)
      end

      def show
        render json: @location.to_json(include: :medical_unit)
      end

      def create
        @location = Location.new(location_params)
        if @location.save
          render json: @location, status: :created
        else
          render json: @location.errors, status: :unprocessable_entity
        end
      end

      def update
        if @location.update(location_params)
          render json: @location
        else
          render json: @location.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @location.destroy
        head :no_content
      end

      private

      def set_location
        @location = Location.find(params[:id])
      end

      def location_params
        params.require(:location).permit(:address, :city, :state, :country, :zip_code, :medical_unit_id)
      end
    end

