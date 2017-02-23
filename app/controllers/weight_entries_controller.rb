class WeightEntriesController < ApplicationController
  def create
    @entry = WeightEntry.new(weight_entry_params)
    @entry.day = Date.current
    @entry.save
    redirect_to root_path
  end

  private

  def weight_entry_params
    params.require(:weight_entry).permit(:value)
  end
end
