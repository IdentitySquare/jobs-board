class Company < ApplicationRecord
  belongs_to :user

  has_many :jobs, dependent: :destroy

  validates :name, :description, :user_id, presence: true
end
