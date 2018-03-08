class Project < ApplicationRecord
 
    has_many :tasks, :dependent => :destroy   
  accepts_nested_attributes_for :tasks, reject_if: proc { |attributes| attributes['title'].blank? }
  validates :title, presence: true                    
    validates :desc, presence: true    
    #attr_accessor :tasks_attributes
    validates_associated :tasks
    validates_presence_of :tasks
end
