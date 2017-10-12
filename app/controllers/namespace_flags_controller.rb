class NamespaceFlagsController < ApplicationController 
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found 
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid  

  before_action :set_namespace_flag, only: [:show, :update, :destroy]

  def index
    @namespace_flags = NamespaceFlag.all
    render json: @namespace_flags, status: :ok
  end

  def create
    @namespace_flag = NamespaceFlag.create!(namespace_flag_params)
    render json: @namespace_flag, status: :created
  end

  def show
    render json: @namespace_flag, status: :ok
  end

  def update
    @namespace_flag.update(namespace_flag_params)
    head :no_content
  end

  def destroy
    @namespace_flag.destroy
    head :no_content
  end

  protected

  def record_not_found(exception)
    render json: {error: exception.message }.to_json, status: :not_found
  end

  def record_invalid(exception)
    render json: { message: exception.message }, status: :unprocessable_entity
  end

  private

  def namespace_flag_params
    params.permit(:name)
  end

  def set_namespace_flag
    @namespace_flag = NamespaceFlag.find(params[:id])
  end
end
