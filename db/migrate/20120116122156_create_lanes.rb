class CreateLanes < ActiveRecord::Migration
  def change
    create_table :lanes do |t|
      t.string :title
      t.integer :board_id

      t.timestamps
    end
  end
end
