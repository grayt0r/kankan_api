class Lane < ActiveRecord::Base
  
  belongs_to :board
  has_many :cards
  
  def self.for(user)
    joins(:board).where(:boards => {:created_by => user.id})
  end
  
end
