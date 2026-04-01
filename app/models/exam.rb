class Exam < ApplicationRecord
  belongs_to :topic
  has_many :questions, dependent: :destroy
  has_many :exam_sessions, dependent: :destroy
  validates :title, :time_duration, presence: true
end
