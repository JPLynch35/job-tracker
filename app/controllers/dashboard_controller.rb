class DashboardController < ApplicationController
  def index
    @job_interests = Job.job_interests
    @top_companies = Company.top_companies_by_interest
    @city_jobs = Job.jobs_by_city
  end
end
