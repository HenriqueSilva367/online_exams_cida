class ModifyQuestionsForDynamicExams < ActiveRecord::Migration[8.0]
  def up
    # Permitir que questões não pertençam a um exame fixo
    change_column_null :questions, :exam_id, true
    
    # Preencher topic_id em questões que ainda não tenham (pegando do exame pai)
    execute <<-SQL
      UPDATE questions 
      SET topic_id = exams.topic_id 
      FROM exams 
      WHERE questions.exam_id = exams.id 
      AND questions.topic_id IS NULL;
    SQL

    # Permitir que sessões existam sem um exame fixo (para simulados dinâmicos)
    change_column_null :exam_sessions, :exam_id, true
  end

  def down
    change_column_null :questions, :exam_id, false
    change_column_null :exam_sessions, :exam_id, false
  end
end
