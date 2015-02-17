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

require 'test_helper'

class TimePeriodTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
