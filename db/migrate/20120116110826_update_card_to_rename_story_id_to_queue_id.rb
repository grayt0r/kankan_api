class UpdateCardToRenameStoryIdToQueueId < ActiveRecord::Migration
  def up
    rename_column :cards, :story_id, :queue_id
  end

  def down
    rename_column :cards, :queue_id, :story_id
  end
end
