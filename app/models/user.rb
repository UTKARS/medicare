class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable
  include DeviseTokenAuth::Concerns::User
   after_initialize :set_provider , :set_uid
   has_many :reports, dependent: :destroy

  # if provider is blank
	def set_provider
	 self[:provider] = "email" if self[:provider].blank?
	end
  
  # if set_uid is blank
	def set_uid
	  self[:uid] = self[:email] if self[:uid].blank? && self[:email].present?
	end

  #get reading for the user 
  def get_readings(type,date)
      case (type)
      when "month_to_date_report"
        start_date = date.to_date.at_beginning_of_month
        end_date = date.to_date
        all_readings = reports.monthly_report(start_date,end_date)
      when "monthly_report"
        start_date = date.to_date.at_beginning_of_month
        end_date = date.to_date.at_end_of_month
        all_readings = reports.monthly_report(start_date,end_date)
      else
        all_readings = reports.daily_report(date || Date.today) 
      end 
      #yield
  end 

  # get_readings do
  #     arr_bgl = all_readings.map(&:bgl)
  #       max_reading = arr_bgl.max
  #       min_reading = arr_bgl.min
  #       avg_reading = arr_bgl.inject(0.0) { |sum, el| sum + el } / arr_bgl.size
  # end
end
