class Comment < ApplicationRecord
  validates_presence_of :content
  belongs_to :job
end