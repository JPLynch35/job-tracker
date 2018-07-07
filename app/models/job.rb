class Job < ApplicationRecord
  validates :title, :level_of_interest, :city, :company_id, presence: true
  belongs_to :company
end
