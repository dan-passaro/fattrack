class WeightEntry < ApplicationRecord
  belongs_to :user

  def self.from(day)
    find_by(day: day)
  end

  def to_s
    "#{value} lbs"
  end
end
