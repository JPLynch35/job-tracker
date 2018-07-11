class Job < ApplicationRecord
  validates :title, :level_of_interest, :city, :company_id, :category_id, presence: true
  belongs_to :company
  belongs_to :category
  has_many :comments, dependent: :destroy

  def self.job_interests
    group(:level_of_interest).order('level_of_interest DESC').count
  end

  def self.jobs_by_city
    group(:city).order('city').count
  end

  def self.sort_by_param(param)
    order(param)
  end

  def self.by_city(param)
    where(param)
  end

  def self.by_category(param)
    where(param)
  end
end
