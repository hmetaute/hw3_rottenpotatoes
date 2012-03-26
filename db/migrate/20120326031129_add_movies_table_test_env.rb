class AddMoviesTableTestEnv < ActiveRecord::Migration
  def up
    if RAILS_ENV == 'test'
      create_table :movies do |t|
        t.string :title
        t.string :rating
        t.text :description
        t.datetime :release_date
        # Add fields that let Rails automatically keep track
        # of when movies are added or modified:
        t.timestamps
      end
    end

  end

  def down
    if RAILS_ENV == 'test'
      drop_table :movies
    end
  end
end
