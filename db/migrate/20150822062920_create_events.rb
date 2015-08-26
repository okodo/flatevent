class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :starts_at
      t.string :recurs_on
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
