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
        @projects=Project.paginate(:page => params[:page], :per_page => 3)    
        @date=params[:obj][:date] 
        @project=Project.new
        @task=params[:project][:tasks_attributes].values       
        val = JSON.parse(params[:project][:tasks_attributes].to_json)                
        value =Array.new                         
        value=val.values.each { |k| k.delete "_destroy" }                                                                         
        val_sum = value.inject(0) {|sum, hash| sum + hash["dur"].to_i}                                           
        rem =8-Task.where(:date => @date).sum("dur")            
        if val_sum > rem 
          if rem == 0
            render :json => { :errors => "Already Duration Time Complter for #{@date}" }, :status => 422         
          else 
            render :json => { :errors => "#{@date} have Remanining #{rem} hours" }, :status => 422           
          end                                 
        else           
          begin                                     
            #if value.map {|tax| @t=Task.new(tax).save!}
            #@tasks=params.require(:project).permit(:tasks_attributes => [:project_id, :date, :title, :desc, :dur])                                  
            #puts @t.values                    
            # @ta=Task.create!(value)         
            # if @ta         
            #   render :json => @ta 
            # else
            #   render :json => { :errors => @ta.errors.full_messages }, :status => 422
            # end                
            Task.create!(value)                                                   
          rescue ActiveRecord::RecordInvalid => invalid            
            render :json => { :errors => invalid.record.errors.full_messages }, :status => 422
          end                     
        end    
  end

  def show_task     
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
      def task_params
        params.require(:project[:tasks_attributes]).permit(:project_id, :date, :title, :desc, :dur)
      end               
end