class SessionAnswer < ApplicationRecord
  belongs_to :exam_session
  belongs_to :question
  belongs_to :answer, optional: true
end
