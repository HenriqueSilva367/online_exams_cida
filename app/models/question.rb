class Question < ApplicationRecord
  belongs_to :exam
  has_many :answers, dependent: :destroy
  validates :title, presence: true
end
