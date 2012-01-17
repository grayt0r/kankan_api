class Card < ActiveRecord::Base
  
  belongs_to :lane
  
  acts_as_taggable_on :tags, :releases # :state, :assigned_to
  
  def self.for(user)
    joins(:lane => :board).where(:lanes => {:boards => {:created_by => user.id}})
  end
  
end
