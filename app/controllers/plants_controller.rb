class PlantsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  # GET /plants
  def index
    render json: Plant.all
  end

  # GET /plants/:id
  def show
    plant = find_plant
    render json: plant
  end

  # PATCH /plants/:id
  def update
    plant = find_plant
    plant.update(is_in_stock: params[:is_in_stock]) #only updates the "is_in_stock"
    render json: plant, status: :accepted
  end

  # DELETE /plants/:id
  def destroy
    plant = find_plant
    plant.destroy
    head :no_content
  end

  # POST /plants
  def create
    plant = Plant.create(plant_params)
    render json: plant, status: :created
  end

  private

  def plant_params
    params.permit(:name, :image, :price, :is_in_stock)
  end

  def find_plant
    Plant.find(params[:id])
  end

  def render_not_found_response
    render json: { error: 'plant not found' }, status: :not_found
  end
end
