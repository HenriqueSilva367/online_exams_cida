class Exam < ApplicationRecord
  has_paper_trail

  belongs_to :topic, optional: true
  has_many :questions, dependent: :destroy
  has_many :exam_sessions
  
  before_destroy :check_if_has_history

  enum :exam_type, { normal: 0, anac_pp: 1 }

  validates :title, presence: true

  private

  def check_if_has_history
    if exam_sessions.any?
      errors.add(:base, "Não é possível excluir este exame pois ele já possui histórico de tentativas dos alunos.")
      throw(:abort)
    end
  end
end
