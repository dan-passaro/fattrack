class WeightEntriesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  def create
    @entry = WeightEntry.new(weight_entry_params)
    @entry.user = current_user
    @entry.day = Date.current
    @entry.save
    redirect_to root_path
  end

  def show
    render json: @entry
  end

  def index
    @entries = WeightEntry.where(user: current_user).order(day: :desc)

    respond_to do |format|
      format.html
      format.json { paginate json: @entries, per_page: 14 }
    end
  end

  def update
    if @entry.update(weight_entry_params)
      render json: @entry, status: :ok, location: @entry
    else
      render json: @entry.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @entry.destroy
    head :no_content
  end

  def today
    @todays_weight = WeightEntry.find_by(day: Date.current, user: current_user)
    render json: @todays_weight
  end

  private

  def weight_entry_params
    params.require(:weight_entry).permit(:value)
  end

  def set_entry
    @entry = WeightEntry.find_by(id: params[:id], user: current_user)
  end
end
