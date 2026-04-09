class ExternalActivity < ApplicationRecord
  belongs_to :user

  validates :title, :score, :date, presence: true
end
