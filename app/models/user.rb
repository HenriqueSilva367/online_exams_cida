class User < ApplicationRecord
  has_paper_trail

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  enum :role, { admin: 0, student: 1, professor: 2, supervisor: 3 }
  enum :student_type, { pilot: 0, flight_attendant: 1 }

  belongs_to :turma, optional: true

  has_many :exam_sessions, dependent: :destroy
  has_many :external_activities, dependent: :destroy
  has_many :exercise_authorizations, dependent: :destroy
  has_many :simulation_releases, dependent: :destroy
  has_many :released_simulations, through: :simulation_releases, source: :exam
  has_one_attached :avatar

  validates :full_name, presence: true
  alias_attribute :name, :full_name

  def total_points
    # Soma de atividades extras + (futura integração com simulados)
    external_activities.sum(:score)
  end
end
