class Task < ApplicationRecord
    belongs_to :project
    validates :date, presence: true
    validates :title, presence: true                  
    validates :desc, presence: false    
    validates :dur, :inclusion => { :in => 0.0..8.0 }, :presence => true
#     attr_accessor :dur
#     #validates_inclusion_of :dur, :in => 0.0..8.0
#     validate :volume_limits

#   private
#   def volume_limits
#     if sum(&:dur) > 8
#         puts dur
#         errors.add(:dur, “cannot”)    
#     end
#   end
    
end
