class ReportValidator < ActiveModel::Validator
 	def validate(record)
		if Report.where("DATE(created_at) = ? and user_id = ?", Date.today, record.user_id).length >= 4
			    record.errors.add(:bgl,"You have exceeded the limit.")
		end
	end
end