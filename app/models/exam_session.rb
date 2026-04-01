class ExamSession < ApplicationRecord
  belongs_to :user
  belongs_to :exam
  has_many :session_answers, dependent: :destroy

  enum :status, { in_progress: 0, canceled: 1, uncompleted: 2, completed: 3 }
end
