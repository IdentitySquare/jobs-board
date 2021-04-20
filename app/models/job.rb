class Job < ApplicationRecord
  belongs_to :company

  has_rich_text :description

  enum job_type: { full_time: 0, part_time: 1 }

  validates :title, :description, :job_type, presence: true
end
