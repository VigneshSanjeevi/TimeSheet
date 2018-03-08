class Task < ApplicationRecord
    belongs_to :project, required: false
    
    validates :date, presence: true
    validates :title, presence: true                  
    validates :desc, presence: false    
    validates :dur, :inclusion => { :in => 0.0..8.0 }, :presence => true
end
