class WeightEntriesController < ApplicationController
  def create
    @entry = WeightEntry.new(weight_entry_params)
    @entry.user = current_user
    @entry.day = Date.current
    @entry.save
    redirect_to root_path
  end

  def index
    @entries = WeightEntry.where(user: current_user).order(day: :desc)

    respond_to do |format|
      format.html
      format.json { render json: @entries }
    end
  end

  def today
    @todays_weight = WeightEntry.find_by(day: Date.current, user: current_user)
    render json: @todays_weight
  end

  private

  def weight_entry_params
    params.require(:weight_entry).permit(:value)
  end
end
