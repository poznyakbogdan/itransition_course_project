class SetDescriptionOfSteps < ActiveRecord::Migration[5.0]
  def change
  	@steps = Step.all
  	@steps.each do |step|
  		step.description = "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Fugiat dolores odit voluptatem. Odio dicta commodi quod maiores ipsa? Aperiam quod fugiat nostrum error saepe, magni blanditiis. Voluptas ex fugit atque. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Fugiat dolores odit voluptatem. Odio dicta commodi quod maiores ipsa? Aperiam quod fugiat nostrum error saepe, magni blanditiis. Voluptas ex fugit atque."
  		step.save
  	end
  end
end
