class WelcomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @todays_weight = WeightEntry.find_by(day: Date.current, user: current_user)

    # If they need to put one in
    @weight_entry = WeightEntry.new
  end
end
