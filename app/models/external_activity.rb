class ExternalActivity < ApplicationRecord
  has_paper_trail

  belongs_to :user

  validates :title, :score, :date, presence: true
end
