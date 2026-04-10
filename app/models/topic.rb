class Topic < ApplicationRecord
  has_paper_trail

  has_many :exams, dependent: :destroy
  validates :title, presence: true
end
