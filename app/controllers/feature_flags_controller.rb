class FeatureFlagsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found 
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid  

  before_action :set_namespace_flag
  before_action :set_feature_flag, only: [:show, :update, :destroy]

  def index
    render json: @namespace_flag.feature_flags, status: :ok
  end

  def show
    render json: @feature_flag, status: :ok
  end

  def create
    @namespace_flag.feature_flags.create!(feature_flag_params)
    render json: @namespace_flag, status: :created
  end

  def update
    @feature_flag.update(feature_flag_params)
    head :no_content
  end

  def destroy
    @feature_flag.destroy
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

  def feature_flag_params
    params.permit(:name)
  end

  def set_namespace_flag
    @namespace_flag = NamespaceFlag.find(params[:namespace_flag_id])
  end

  def set_feature_flag
    @feature_flag = @namespace_flag.feature_flags.find_by!(id: params[:id]) if @namespace_flag
  end

  def set_namespace_name

  end
end
