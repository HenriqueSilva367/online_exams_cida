class Answer < ApplicationRecord
  belongs_to :question
  has_many :session_answers
  
  before_destroy :check_if_has_answers

  validates :title, presence: true

  private

  def check_if_has_answers
    if session_answers.any?
      errors.add(:base, "Não é possível excluir esta alternativa pois ela foi escolhida por alunos em simulados passados.")
      throw(:abort)
    end
  end
end
