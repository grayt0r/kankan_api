class AddStoryMapIdToCards < ActiveRecord::Migration
  def change
    add_column :cards, :story_map_id, :integer
  end
end
