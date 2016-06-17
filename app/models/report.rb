class Report < ApplicationRecord
  	belongs_to :user

  	validates_with DailyReportEntryValidator #including customer validation here for the limit 4 in a day
  	scope :daily_report, ->(date) { where("DATE(created_at) = ?", date.to_date) }
  	scope :monthly_report, ->(start_date,end_date) { where("DATE(created_at) >= ? and DATE(created_at) <= ?", start_date,end_date) }
end
