# frozen_string_literal: true

# Reservations
module Reservations
  # Get work days
  class WorkDay
    def self.work_day_between(start_at, end_at)
      (start_at.to_date..end_at.to_date).select { |date| work_day(date) }
    end

    def self.remove_days_off(week_days)
      days = []
      week_days.map do |day|
        days << day unless day_offs(day.year).include?(day)
      end
      days
    end

    def self.work_day(date)
      return if date != date.try(:to_date)

      ![0].include?(date.wday)
    end

    def self.day_offs(year)
      DayOff.year(year)
    end
  end
end
