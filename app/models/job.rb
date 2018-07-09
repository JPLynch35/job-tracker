class Job < ApplicationRecord
  validates :title, :level_of_interest, :city, :company_id, :category_id, presence: true
  belongs_to :company
  belongs_to :category

  def self.job_interests
    group(:level_of_interest).order('level_of_interest DESC').count
  end

  def self.jobs_by_city
    group(:city).order('city').count
  end
end 
