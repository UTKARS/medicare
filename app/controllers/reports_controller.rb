class ReportsController < ApplicationController
	before_action :authenticate_user!, except: [:home]

	#creating reports
	def create		
			report = current_user.reports.build(reports_params)
		if  report.save
			render :json => {status: true, data: report}
		else
			render :json => {status: false, massage: report.errors}
		end
	end

	#fetching reports for monthly , daily and for month to date
	def index
		 	all_readings = current_user.get_readings(params[:type],params[:date])
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

	#https://github.com/rails/rails/issues/24505 - reason
	def home
		
	end

	private

	def reports_params
		params.require(:report).permit!
	end

end
