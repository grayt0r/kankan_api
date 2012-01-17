class Board < ActiveRecord::Base
  
  belongs_to :user
  has_many :lanes
  
  def self.for(user)
    where(:created_by => user.id)
  end
  
  #def as_json(options={})
  #  super({:include => { :lanes => {:include => :cards}}})
  #end
  
  #def as_json(options={})
  #  super({
  #    :except => [:created_at, :updated_at], :include => {
  #      :lanes => {
  #        :except => [:board_id, :created_at, :updated_at], :include => {
  #          :cards => {
  #            :except => [:lane_id, :created_at, :updated_at]
  #          }
  #        }
  #      }
  #    }
  #  })
  #end
  
end