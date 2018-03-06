class Project < ApplicationRecord
  #TASK_TIME_MAX = 8
    has_many :tasks, :dependent => :destroy
    #validates_associated :tasks
  accepts_nested_attributes_for :tasks, allow_destroy: true
  validates :title, presence: true                    
    validates :desc, presence: true    
    # attr_accessor :tasks_attributes
#      before_create :show_me_test_param

# private

# def show_me_test_param
#   raise "#{dur}"
# end
    #  validate :check
    #  def check
    #   if sum(params[:project][:tasks_attributes]['3']) > 8
    #     errors.add_to_base("This person is invalid because ...")
    #   end
    #  end

    # def initialize(tasks_attributes)
    #   params.each do |key, value|
    #   instance_variable_set("@#{key}", value)
    #   end
    # end    
    # validate :total
    # private
    # def total  
    #   if self.tasks.sum(:dur) > 8 
    #     errors.add(:dur, "Time Project Overload")
    #   end
    # end
  #   def self.validates_as_choice(dur, 8, options={})
  #   validates dur, :inclusion => { { :in => 1..n }.merge!(options) }
  # end
    
  #validate :volume_limits

  # private

  # def volume_limits
  #   if sum(self.dur) > 8
  #     errors.add(:dur, “cannot”)    
  #   end
  # end
  #   before_save :calculate_and_store_amount                              # the critical code 2/2
  
  # private
  # def calculate_and_store_amount
  #   # does not include amounts of items you marked for destruction
  #   self.amount = tasks.reject(&:marked_for_destruction?).sum(&:dur)
  # end

    # before_save :total
    # private
    # def total  
    #   if tasks.collect(&:dur).sum > 8
    #     errors.add(:dur, "Time Project Overload")
    #   end
    # end
   
    
    
  # validate :sum
  #   def sum(dur, from = 0)
  #     dur.inject(from, :+)
  #     if from > 8
  #       error.add(:dur, "Time Overload")
  #     end
  #   end  
   
end
