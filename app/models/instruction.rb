class Instruction < ApplicationRecord
	belongs_to :user
	has_many :steps

	validates :name, presence: true
end
