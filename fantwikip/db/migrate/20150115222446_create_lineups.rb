class CreateLineups < ActiveRecord::Migration
  def change
    create_table :lineups do |t|

      t.timestamps
    end
  end
end
