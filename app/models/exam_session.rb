class ExamSession < ApplicationRecord
  belongs_to :user
  belongs_to :exam
  has_many :session_answers, dependent: :destroy

  enum :status, { in_progress: 0, canceled: 1, uncompleted: 2, completed: 3 }
  enum :result_status, { pending: 0, approved: 1, failed: 2, second_chance: 3 }

  def calculate_anac_result!
    return unless exam.anac_pp?
    
    topics_data = {}
    questions = exam.questions.includes(:topic)
    
    questions.each do |q|
      t_id = q.topic_id || exam.topic_id
      topics_data[t_id] ||= { correct: 0, total: 0, title: (q.topic&.title || exam.topic.title) }
      topics_data[t_id][:total] += 1
    end
    
    session_answers.each do |sa|
      if sa.answer&.is_correct
        q = sa.question
        t_id = q.topic_id || exam.topic_id
        topics_data[t_id][:correct] += 1 if topics_data[t_id]
      end
    end
    
    below_70_count = 0
    any_below_30 = false
    
    topics_data.each do |_id, data|
      pct = data[:total] > 0 ? (data[:correct].to_f / data[:total] * 100) : 0
      below_70_count += 1 if pct < 70
      any_below_30 = true if pct < 30
    end
    
    final_status = if any_below_30 || below_70_count > 2
                     :failed
                   elsif below_70_count > 0
                     :second_chance
                   else
                     :approved
                   end
                   
    update!(result_status: final_status, detailed_results: topics_data)
  end
end
