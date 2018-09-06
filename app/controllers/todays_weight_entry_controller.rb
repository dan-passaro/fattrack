class TodaysWeightEntryController < ApplicationController
  def show
    @weight = WeightEntry.find_by(day: Date.current, user: current_user)
    render json: @weight
  end

  def update
    render json: {fizz: "buzz"}
  end
end
