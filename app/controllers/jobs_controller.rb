class JobsController < ApplicationController
  def index
    @heading = "All Jobs"
    sort_params = {'location' => :city, 'interest' => :level_of_interest, 'title' => :title}
    if params[:company_id]
      @company = Company.find(params[:company_id])
      @heading += " at #{@company.name}"
      @jobs = @company.jobs
    elsif params[:sort]
      @jobs = Job.order(sort_params[params[:sort]]).includes(:company)
    elsif params[:location]
      @heading = "#{params[:location]} Jobs"
      @jobs = Job.where(city: params[:location])
    elsif params[:category]
      @heading = "#{params[:category]} Jobs"
      category = Category.find_by(title: params[:category])
      @jobs = Job.where(category_id: category.id)
    else
      @jobs = Job.all.includes(:company)
    end
  end

  def new
    if params[:company_id]
      # @heading = "All of this company's jobs"
      @company = Company.find(params[:company_id])
      @job = @company.jobs.new
      # Job.where(company_id:params[:company_id])
    else
      # @heading = "All jobs"
      @job = Job.new
    end
  end

  def create
    @company = Company.find(job_params[:company_id])
    @job = @company.jobs.new(job_params)
    if @job.save
      flash[:success] = "You created #{@job.title} at #{@company.name}"
      if params[:company_id]
        redirect_to company_job_path(@company, @job)
      else
        redirect_to job_path(@job) # use render?
      end
    else
      flash.notice = "Job not created."
      render :new
    end
  end

  def show
    @flag = true if params[:company_id]
    @job = Job.find(params[:id])
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
    job = Job.find(params[:id])
    job.destroy

    flash[:success] = "#{job.title} was successfully deleted!"
    if params[:company_id]
      redirect_to company_jobs_path(job.company)
    else
      redirect_to jobs_path
    end
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :level_of_interest, :company_id, :city, :category_id)
  end
end
