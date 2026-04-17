class Question < ApplicationRecord
  has_paper_trail

  belongs_to :exam, optional: true
  belongs_to :topic
  has_many :answers, dependent: :destroy
  has_many :session_answers
  has_one_attached :explanation_image
  has_many_attached :explanation_images
  
  before_destroy :check_if_has_answers

  validates :title, presence: true, uniqueness: { case_sensitive: false, message: "Este enunciado já foi cadastrado em outra questão." }

  private

  def check_if_has_answers
    if session_answers.any?
      errors.add(:base, "Não é possível excluir esta questão pois ela já foi respondida por alunos em simulados passados.")
      throw(:abort) # Aborts the destruction process
    end
  end
end
