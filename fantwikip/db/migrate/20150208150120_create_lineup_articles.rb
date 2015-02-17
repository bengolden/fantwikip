class CreateLineupArticles < ActiveRecord::Migration
  def change
    create_table :lineup_articles do |t|
    	t.integer :lineup_id
			t.integer :article_id
			t.integer :last_year_views
			t.integer :views
			t.integer :days_passed
			t.float :points, default: 0

      t.timestamps
    end
  end
end
