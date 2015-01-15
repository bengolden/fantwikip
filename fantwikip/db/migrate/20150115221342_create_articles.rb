class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :team_id
      t.string :name
      t.integer :jan_2014_views
      t.integer :feb_2014_views
      t.integer :mar_2014_views
      t.integer :jan_2015_views
      t.integer :feb_2015_views
      t.integer :mar_2015_views
      t.integer :jan_2015_projected_views
      t.integer :feb_2015_projected_views
      t.integer :mar_2015_projected_views

      t.timestamps
    end
  end
end
