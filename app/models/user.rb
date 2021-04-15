class User < ApplicationRecord
  # :lockable, :timeoutable, :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :trackable

  # model relations
  has_many :companies, dependent: :destroy

  # model validations
  validates :email, presence: true,
                    format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'must be a valid address' }

  validates :first_name, :last_name, presence: true
end
