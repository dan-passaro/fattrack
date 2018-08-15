module WeightEntriesHelper

  # Describe the day, relative to now.
  #
  # E.g. "Today", "Yesterday," "Monday," or a normal date string if
  # it's more than a week ago.
  def day_in_words date
    day = date.respond_to?(:to_date) ? date.to_date : date
    days_ago = Date.today - day

    case days_ago
    when 0
      "Today"
    when 1
      "Yesterday"
    when 2..7
      day.strftime('%A')  # weekday
    else
      day.strftime  # YYYY-MM-DD
    end
  end
end
