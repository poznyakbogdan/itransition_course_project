class Instruction < ApplicationRecord

	belongs_to :user
	belongs_to :category
	has_many :steps, dependent: :destroy

	validates :name, presence: true

	accepts_nested_attributes_for :steps

	acts_as_taggable
	acts_as_votable
end
