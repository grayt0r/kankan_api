class FixForeignKeyInCardsTable < ActiveRecord::Migration
  def up
    change_table :cards do |t|
      t.remove :story_map_id
      t.references :story
    end
  end
end
