class WelcomeController < ApplicationController
  before_action :authenticate_user!

  def index
    # redirect_to new_user_session_path unless user_signed_in?

    @todays_weight = WeightEntry.from(Date.current)

    # If they need to put one in
    @weight_entry = WeightEntry.new
  end
end
