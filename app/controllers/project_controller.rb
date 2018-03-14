class ProjectController < ApplicationController
  before_action :authenticate_user!
  def index
    @projects=Project.paginate(:page => params[:page], :per_page => 4) 
    @project=Project.new
  end

  def create         
    @project=Project.new(project_params)
	  if @project.save
      render :json => @project
    else
      render :json => { :errors => @project.errors.full_messages }, :status => 422
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
    # @projects=Project.paginate(:page => params[:page], :per_page => 2) 
    #     @date=params[:obj][:date]         
    #     @task=params[:project][:tasks_attributes].values               
    #     val = JSON.parse(params[:project][:tasks_attributes].to_json)                
    #     value =Array.new                       
    #     value=val.values.each { |k| k.delete "_destroy" }                                                                         
    #     val_sum = value.inject(0) {|sum, hash| sum + hash["dur"].to_i}                                           
    #     rem =8-Task.where(:date => @date).sum("dur")            
    #     if val_sum > rem 
    #       if rem == 0
    #         render :json => { :errors => "Already Duration Time Complter for #{@date}" }, :status => 422         
    #       else 
    #         render :json => { :errors => "#{@date} have Remanining #{rem} hours" }, :status => 422           
    #       end                                 
    #     else           
    #       begin                                             
    #         #if value.map {|tax| @t=Task.new(tax).save!}            
    #        if Task.create!(value)            
    #         result=render_to_string(:partial => '/project/show_tasks', :locals => {:@projects => @projects})                    
    #         render :json => {success: "Tasks Added Sucessfully", project: result}           
    #        end                                              
    #       rescue ActiveRecord::RecordInvalid => invalid            
    #         render :json => { :errors => invalid.record.errors.full_messages }, :status => 422
    #       end                     
    #     end         
    @projects=Project.paginate(:page => params[:page], :per_page => 2)	 
	  @date=params[:obj][:date]
	  has_errors = false
	  value=Array.new
	  params[:project][:tasks_attributes].values.each do |tast_attr|
  		value << tast_attr.except("_destroy")
  	  @tasks = Task.new(tast_attr.except("_destroy"))
		  unless @tasks.valid?
			  has_errors=true
			  break
		  end
	  end
    val_sum = value.inject(0) {|sum, hash| sum + hash["dur"].to_i}
	  rem=8-Task.where(:date => @date).sum(:dur)	
	  if  val_sum > rem || has_errors==true
	  	if val_sum > rem
        if rem == 0
          render :json => { :errors => "Already Duration Time Complete for #{@date}" }, :status => 422         
        else 
         render :json => { :errors => "#{@date} have Remanining #{rem} hours" }, :status => 422           
        end  
		  else
			  render :json => { :errors => @tasks.errors.full_messages}, :status => 422
		  end
	  else	
		  if Task.create(value)
			  result=render_to_string(:partial => '/project/show_tasks', :locals => {:@projects => @projects})
			  render :json => {success: "Tasks Successfully Added", project: result}
		  end
	  end  
  end

  def show_task     
    @project= Project.new    
    @projects=Project.paginate(:page => params[:page], :per_page => 2) 
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
      def task_params
        params.require(:project).require(:tasks_attributes).permit(:project_id, :date, :title, :desc, :dur, :_destroy)
      end               
end