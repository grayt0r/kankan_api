class RenameStoryMapToBoard < ActiveRecord::Migration
  def up
    rename_table :story_maps, :boards
    rename_column :stories, :story_map_id, :board_id
  end

  def down
    rename_table :boards, :story_maps
    rename_column :stories, :board_id, :story_map_id
  end
end
