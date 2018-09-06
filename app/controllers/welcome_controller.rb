class WelcomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @todays_weight = WeightEntry.find_by(day: Date.current, user: current_user)

    @has_old_entries = WeightEntry.where(user: current_user).exists

    # If they need to put one in
    @weight_entry = WeightEntry.new

    respond_to do |format|
      format.html
      format.json { render json: {
                             todays_weight: todays_weight,
                             has_old_entries: @has_old_entries,
                           } }

    end
  end
end
