class JobsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @jobs = Job.user_jobs(@user, params)

    # show flash message with search term, number of results, and reset search button
    if params[:search]
      result = {:count => @jobs.count, :term => params[:search]}
      flash.now[:notice] = render_to_string :partial => '/shared/search_results', :object => result, :as => :result
    end
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(permitted_params)
    @job.user_id = current_user.id
    respond_to do |format|
      if @job.save
        format.html { redirect_to root_path, notice: 'Your job has been posted.' }
      else
        format.html { render :new }
      end
    end
  end

  def show
    @job = Job.find(params[:id])
  end

  private

  def permitted_params
    params.require(:job).permit(:name, :description, :status, :employment_type)
  end
end
