class Api::V1::SpecializationsController < ApplicationController
      before_action :set_specialization, only: [:show, :update, :destroy]

      def index
        @specializations = Specialization.all
        render json: @specializations
      end

      def show
        render json: @specialization
      end

      def create
        @specialization = Specialization.new(specialization_params)
        if @specialization.save
          render json: @specialization, status: :created
        else
          render json: @specialization.errors, status: :unprocessable_entity
        end
      end

      def update
        if @specialization.update(specialization_params)
          render json: @specialization
        else
          render json: @specialization.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @specialization.destroy
        head :no_content
      end

      private

      def set_specialization
        @specialization = Specialization.find(params[:id])
      end

      def specialization_params
        params.require(:specialization).permit(:specialization_category)
      end
    
  
end
