class Topic < ApplicationRecord
  has_paper_trail

  has_many :exams, dependent: :destroy
  has_many :questions, dependent: :nullify
  validates :title, presence: true
end
