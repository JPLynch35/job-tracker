class Job < ApplicationRecord
  validates :title, :level_of_interest, :city, :company_id, :category_id, presence: true
  belongs_to :company
  belongs_to :category
end 
