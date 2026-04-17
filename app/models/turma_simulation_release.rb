class TurmaSimulationRelease < ApplicationRecord
  belongs_to :turma
  belongs_to :exam

  validates :turma_id, uniqueness: { scope: :exam_id, message: "Já possui este simulado liberado para esta turma" }
end
