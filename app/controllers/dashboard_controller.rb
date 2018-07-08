class DashboardController < ApplicationController
  def index
    @job_interests = Job.job_interests
    @top_companies = Company.top_companies_by_interest
  end
end
