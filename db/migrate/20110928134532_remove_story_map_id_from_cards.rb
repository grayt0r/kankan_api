class RemoveStoryMapIdFromCards < ActiveRecord::Migration
  def up
    remove_column :cards, :story_map_id
  end

  def down
    add_column :cards, :story_map_id, :integer
  end
end
