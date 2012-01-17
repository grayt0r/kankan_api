class CreateStoryMaps < ActiveRecord::Migration
  def change
    create_table :story_maps do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end