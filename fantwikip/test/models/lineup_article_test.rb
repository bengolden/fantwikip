# == Schema Information
#
# Table name: lineup_articles
#
#  id              :integer          not null, primary key
#  lineup_id       :integer
#  article_id      :integer
#  last_year_views :integer
#  views           :integer
#  days_passed     :integer
#  points          :float
#  created_at      :datetime
#  updated_at      :datetime
#

require 'test_helper'

class LineupArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
