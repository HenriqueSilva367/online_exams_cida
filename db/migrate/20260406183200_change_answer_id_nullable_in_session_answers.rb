class ChangeAnswerIdNullableInSessionAnswers < ActiveRecord::Migration[8.0]
  def change
    change_column_null :session_answers, :answer_id, true
  end
end
