class Job < ApplicationRecord
  belongs_to :company

  has_rich_text :description

  enum job_type: { 'Full-time': 0, 'Part-time': 1 }

  validates :title, :description, :job_type, presence: true
end
