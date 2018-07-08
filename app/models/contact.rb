class Contact < ApplicationRecord
  validates :name, :role, :email, :company_id, presence: true
  belongs_to :company
end
