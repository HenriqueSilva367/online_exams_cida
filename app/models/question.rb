class Question < ApplicationRecord
  belongs_to :exam
  belongs_to :topic, optional: true
  has_many :answers, dependent: :destroy
  validates :title, presence: true
end
