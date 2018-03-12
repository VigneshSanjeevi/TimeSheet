class Project < ApplicationRecord
 
    has_many :tasks, :dependent => :destroy   
  accepts_nested_attributes_for :tasks, allow_destroy: true
  validates :title, presence: true, length: { maximum: 30, minimum:5 }                  
    validates :desc, presence: true    
    #attr_accessor :tasks_attributes
    validates_associated :tasks
    validates_presence_of :tasks
end
