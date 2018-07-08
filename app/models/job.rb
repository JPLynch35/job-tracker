class Job < ApplicationRecord
  validates :title, :level_of_interest, :city, :company_id, :category_id, presence: true
  belongs_to :company
  belongs_to :category

  def self.job_interests
    group(:level_of_interest).order('level_of_interest DESC').count
  end

  def self.top_companies_by_interest
    group(:company_id).average(:level_of_interest).order.limit(3)
  end
end 
