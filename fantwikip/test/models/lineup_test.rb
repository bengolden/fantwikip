# == Schema Information
#
# Table name: lineups
#
#  id             :integer          not null, primary key
#  time_period_id :integer
#  team_id        :integer
#  created_at     :datetime
#  updated_at     :datetime
#

require 'test_helper'

class LineupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
