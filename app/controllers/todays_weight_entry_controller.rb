class TodaysWeightEntryController < ApplicationController
  before_action :authenticate_user!
  skip_before_filter :verify_authenticity_token
  wrap_parameters :weight_entry, format: [:json]

  def show
    @weight = WeightEntry.find_by(day: Date.current, user: current_user)
    render json: @weight
  end

  def update
    entry_params = {
      day: Date.current,
      user: current_user,
    }

    @entry = WeightEntry.find_or_create_by(entry_params)
    @entry.update(weight_entry_params)
    @entry.save
    @entry.reload

    render json: @entry
  end

  private

  def weight_entry_params
    params.require(:weight_entry).permit(:value)
  end
end
