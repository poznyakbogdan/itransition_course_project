class Instruction < ApplicationRecord

	belongs_to :user
	belongs_to :category
	has_many :steps, dependent: :destroy
	has_many :comments, through: :steps

	validates :name, presence: true

	accepts_nested_attributes_for :steps

	acts_as_taggable
	acts_as_votable

	self.per_page = 12

	after_save ThinkingSphinx::RealTime.callback_for(:instruction)

end
