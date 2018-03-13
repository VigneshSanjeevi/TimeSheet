class Task < ApplicationRecord
    belongs_to :project, class_name: "Project", optional: true 
    #validates :project, presence: true     
    validates :project_id, presence: true  
    validates :date, presence: true
    validates :title, presence: true                  
    validates :desc, presence: false    
    validates :dur, :inclusion => { :in => 0.0..8.0 }, :presence => true, :numericality => true
    
end
