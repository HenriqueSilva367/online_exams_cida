class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { admin: 0, student: 1 }

  has_many :exam_sessions, dependent: :destroy
  has_one_attached :avatar

  validates :name, presence: true
end
