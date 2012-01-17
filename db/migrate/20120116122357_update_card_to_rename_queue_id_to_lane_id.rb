class UpdateCardToRenameQueueIdToLaneId < ActiveRecord::Migration
  def up
    rename_column :cards, :queue_id, :lane_id
  end

  def down
    rename_column :cards, :lane_id, :queue_id
  end
end
