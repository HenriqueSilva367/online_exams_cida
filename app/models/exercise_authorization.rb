class ExerciseAuthorization < ApplicationRecord
  belongs_to :user
  belongs_to :topic

  validates :authorized, inclusion: { in: [true, false] }
end
