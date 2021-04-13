class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :trackable
  has_many :companies, dependent: :destroy
  validates :email, presence: true,
                    format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'must be a valid address' }
  validates :first_name, :last_name, presence: true
end
