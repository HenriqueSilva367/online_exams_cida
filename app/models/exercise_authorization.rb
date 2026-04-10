class ExerciseAuthorization < ApplicationRecord
  has_paper_trail

  belongs_to :user
  belongs_to :topic

  validates :authorized, inclusion: { in: [true, false] }
end
