class JobsController < ApplicationController
  def index
    @heading = "All Jobs"
    sort_params = {'location' => :city, 'interest' => "level_of_interest desc", 'title' => :title}
    if params[:company_id]
      @company = Company.find(params[:company_id])
      @jobs = @company.jobs
      @heading += " at #{@company.name}"
    elsif params[:sort]
      @jobs = Job.includes(:company).sort_by_param(sort_params[params[:sort]])
    elsif params[:location]
      @jobs = Job.by_city(city: params[:location])
      @heading = "#{params[:location]} Jobs"
    elsif params[:category]
      category = Category.find_by(title: params[:category])
      @jobs = Job.by_category(category_id: category.id)
      @heading = "#{params[:category]} Jobs"
    else
      @jobs = Job.all.includes(:company)
    end
  end

  def new
    if params[:company_id]
      @company = Company.find(params[:company_id])
      @job = @company.jobs.new
    else
      @job = Job.new
    end
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      flash[:success] = "You created #{@job.title} at #{@job.company.name}"
      if params[:company_id]
        redirect_to company_job_path(@job.company, @job)
      else
        redirect_to job_path(@job)
      end
    else
      flash.notice = "Job not created."
      render :new
    end
  end

  def show
    @flag = true if params[:company_id]
    @job = Job.includes(:company).find(params[:id])
    @comment = Comment.new
    @comment.job_id = @job.id
  end

  def edit
    @job = Job.find(params[:id])
    @company = @job.company if params[:company_id]
  end

  def update
    @job = Job.find(params[:id])
    @company = @job.company
    @job.update(job_params)
    if @job.save
      flash[:success] = "#{@job.title} updated!"
      if params[:company_id]
        redirect_to company_job_path(@company, @job)
      else
        redirect_to job_path(@job)
      end
    else
      flash.notice = "Job not updated."
      render :edit
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy

    flash[:success] = "#{@job.title} was successfully deleted!"
    if params[:company_id]
      redirect_to company_jobs_path(@job.company)
    else
      redirect_to jobs_path
    end
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :level_of_interest, :company_id, :city, :category_id)
  end
end
