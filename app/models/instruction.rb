class Instruction < ApplicationRecord
	belongs_to :user
	has_many :steps, dependent: :destroy

	validates :name, presence: true
end
