class Task < ApplicationRecord
    belongs_to :project, class_name: "Project", optional: true 
    #validates :project, presence: true     
    validates :project_id, presence: true, allow_blank: false 
    validates :date, presence: true, allow_blank: false
    validates :title, presence: true, allow_blank: false
    # def initialize
    #     @errors = ActiveModel::Errors.new(self)
    #   end
    #   def validate!
    #     errors.add(:title, :blank, message: "cannot be nil") if name.nil?
    #     errors.add(:project_id, :blank, message: "cannot be nil") if project_id.nil?
    #     #errors.add(:date, :blank, message: "cannot be nil") if date.nil?
    #     errors.add(:dur, :blank, message: "cannot be nil") if dur.nil?        
    #   end                 
    validates :desc, presence: false    
    validates :dur, :inclusion => { :in => 0.0..8.0 }, :presence => true, :numericality => true, allow_blank: false
end
