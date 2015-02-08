# == Schema Information
#
# Table name: time_periods
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  duration   :string(255)
#  start_date :date
#  end_date   :date
#  created_at :datetime
#  updated_at :datetime
#

class TimePeriod < ActiveRecord::Base

	def active?
		Time.now > self.start_date && !expired?
	end

	def expired?
		Time.now > self.end_date
	end

end
