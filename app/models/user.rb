class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable
  include DeviseTokenAuth::Concerns::User
   after_initialize :set_provider , :set_uid
   has_many :reports, dependent: :destroy

	def set_provider
	    #byebug
	 self[:provider] = "email" if self[:provider].blank?
	end

	def set_uid
	  #byebug
	  self[:uid] = self[:email] if self[:uid].blank? && self[:email].present?
	end 

	def limit_exceeded?
  		self.reports.where("DATE(created_at) = ?", Date.today).count < 4
  	end
end
