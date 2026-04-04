class Exam < ApplicationRecord
  belongs_to :topic
  has_many :questions, dependent: :destroy
  has_many :exam_sessions, dependent: :destroy
  
  enum :exam_type, { normal: 0, anac_pp: 1 }

  validates :title, :time_duration, presence: true
end
