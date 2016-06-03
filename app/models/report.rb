class Report < ApplicationRecord
  belongs_to :user

    def self.get_readings(user,type,date)
  		 case (type)
			when "daily_report"
			  all_readings = user.reports.where("DATE(created_at) = ?", date.to_date)
			when "month_to_date_report"
			  start_date = date.to_date.at_beginning_of_month
			  end_date = date.to_date
			  all_readings = user.reports.where("DATE(created_at) >= ? and DATE(created_at) <= ?", start_date,end_date)
			when "monthly_report"
			  start_date = date.to_date.at_beginning_of_month
			  end_date = date.to_date.at_end_of_month
			  all_readings = user.reports.where("DATE(created_at) >= ? and DATE(created_at) <= ?", start_date,end_date)
		 	end	
  	end

end