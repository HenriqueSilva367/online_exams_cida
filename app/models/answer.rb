class Answer < ApplicationRecord
  has_paper_trail

  belongs_to :question
  has_many :session_answers
  
  before_destroy :check_if_has_answers

  validates :title, presence: true

  before_save :ensure_only_one_correct_answer, if: -> { is_correct? && (new_record? || is_correct_changed?) }

  private

  def ensure_only_one_correct_answer
    question.answers.where.not(id: id).update_all(is_correct: false)
  end

  def check_if_has_answers
    if session_answers.any?
      errors.add(:base, "Não é possível excluir esta alternativa pois ela foi escolhida por alunos em simulados passados.")
      throw(:abort)
    end
  end
end
