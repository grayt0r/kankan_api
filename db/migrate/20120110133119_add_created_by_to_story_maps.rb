class AddCreatedByToStoryMaps < ActiveRecord::Migration
  def change
    add_column :story_maps, :created_by, :integer
  end
end
