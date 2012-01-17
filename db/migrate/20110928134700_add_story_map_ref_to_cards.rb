class AddStoryMapRefToCards < ActiveRecord::Migration
  
  def change
    
    change_table :cards do |t|
      t.references :story_map
    end
    
  end
  
end
