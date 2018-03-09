class ProjectController < ApplicationController
  before_action :authenticate_user!
  def index
    @projects=Project.paginate(:page => params[:page], :per_page => 6) 
    @project=Project.new
  end

  def create         
    @project=Project.new(project_params)
	  if @project.save
      redirect_to root_path, notice: "Project added successsfully"          
	  else
	    render 'new'
	  end
  end

  def new
    @project = Project.new   
    #@project.tasks.build
  end

  def edit
    @project = Project.find(params[:id])  
  end

  def update    
    @project = Project.find(params[:id])
	  if @project.update(project_params)
	    redirect_to @project, notice: "Project Update successsfully"   
	  else
	    render 'edit'
    end
  end

  def update_all_task 
    @projects=Project.paginate(:page => params[:page], :per_page => 3)    
        @date=params[:obj][:date]                                    
        val=0
        count=0
        valid=0
        @tasks=params[:project][:tasks_attributes]        
        @tasks.each do |i|
         j=@tasks[i]
          val+=j["dur"].to_i 
          if j["title"].blank? || j["dur"].blank?                  
            valid+=1
          end
          count+=1
        end   
         
    rem =8-Task.where(:date => @date).sum("dur") 
    if val > 8 || val > rem || @date.blank? || valid > 0
      if val > 8               
         flash[:alert] = "Check the Duration Time.. Maximum 8 hours only accept per day"        
      elsif val > rem 
        if rem ==0
         flash[:alert] = "Already Duration Time Complete for #{@date}"
        else
          flash[:alert] = "#{@date} have Remaining #{rem} hours"
        end
      elsif @date.blank?
        flash[:alert] = "Please Select Date"  
      else
        flash[:alert] = "Fill Data Correctly"
      end
      
      @projects=Project.paginate(:page => params[:page], :per_page => 3) 
      @project = Project.new
      count.times {@project.tasks.build}
      count=0
      @tasks.each do |i|
        j=@tasks[i]
        @project.tasks[count].project_id = j["project_id"]
        @project.tasks[count].title = j["title"]
        @project.tasks[count].desc = j["desc"]
        @project.tasks[count].dur = j["dur"]
        count+=1
      end   
      count=0
      render 'show_task'
    else      
      @tasks.each do |i|
      j=@tasks[i]
          @task=Task.create(
          :project_id => j["project_id"],
          :date => @date,
          :title => j["title"],
          :desc => j["desc"],
          :dur => j["dur"]
          )
          if @task.save
            flash[:notice] = 'Updated'
          else
            flash[:notice] =' Not Updated'
          end                        
        end      
          redirect_to '/project/show_task'
        end
    
  end

  def show_task 
    @task=Task.new
    @project= Project.new
    #@project.tasks.build
    @projects=Project.paginate(:page => params[:page], :per_page => 3) 
  end

  def show  
    @project = Project.find(params[:id])
    @task = Task.find_by_id params[:id]
  end

  def destroy
    @project = Project.find_by_id params[:id]
    @project.destroy  
    redirect_to root_path
  end

  private
		  def project_params
        params.require(:project).permit(:title, :desc, :tasks_attributes => [:id, :project_id, :date, :title, :desc, :dur, :_destroy])
      end  
                
end
