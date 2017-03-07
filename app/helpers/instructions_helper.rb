module InstructionsHelper

	def get_category(instruction)
		@categories[instruction.category_id - 1]
	end

end
