class Question < ApplicationRecord
  belongs_to :exam
  belongs_to :topic, optional: true
  has_many :answers, dependent: :destroy
  has_many :session_answers
  has_one_attached :explanation_image
  has_many_attached :explanation_images
  
  before_destroy :check_if_has_answers

  validates :title, presence: true

  private

  def check_if_has_answers
    if session_answers.any?
      errors.add(:base, "Não é possível excluir esta questão pois ela já foi respondida por alunos em simulados passados.")
      throw(:abort) # Aborts the destruction process
    end
  end
end
