# frozen_string_literal: true

module Helpers
  def check_date_for_schedule(day_of_month)
    # Adapt task to only run on a given day of month on scheduler
    abort("Exiting: Not day #{day_of_month} of the month") if Date.today.day != day_of_month
  end
end