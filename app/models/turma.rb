class Turma < ApplicationRecord
  has_many :users, dependent: :nullify
  has_many :turma_simulation_releases, dependent: :destroy
  has_many :released_simulations, through: :turma_simulation_releases, source: :exam

  validates :name, presence: true, uniqueness: true

  def to_s
    name
  end
end
