class RenameStoryToQueue < ActiveRecord::Migration
  def change
    rename_table :stories, :queues
  end
end
