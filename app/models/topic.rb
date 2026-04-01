class Topic < ApplicationRecord
  has_many :exams, dependent: :destroy
  validates :title, presence: true
end
