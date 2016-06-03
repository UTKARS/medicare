class ReportsController < ApplicationController
	before_action :authenticate_user!

	#creating reports
	def create
		user = User.find(params[:user_id])
		if user.limit_exceeded?
			report = user.reports.create(reports_params)
			render :json => {status: true, data: report}
		else
			render :json => {status: false, massage: "Limit is exceeded for the day!"}
		end
	end

	#fetching reports 
	def index
		 user = User.find(params[:user_id])
		 	all_readings = Report.get_readings(user,params[:type],params[:date])
		 	unless all_readings.blank?
				arr_bgl = all_readings.map(&:bgl)
				max_reading = arr_bgl.max
				min_reading = arr_bgl.min
				avg_reading = arr_bgl.inject(0.0) { |sum, el| sum + el } / arr_bgl.size
				render :json => {status: true,all_readings: all_readings,
					max_reading: max_reading,min_reading: min_reading,avg_reading: avg_reading}
			else
				render :json => {status: false,massage: "It seems like no reading available"}
			end
	end

	private

	def reports_params
		params.require(:report).permit!
	end

end
