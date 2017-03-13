class InstructionPdf < Prawn::Document
	require 'rqrcode'
	def initialize(instruction)
		super(top_margin: 70)
		@instruction = instruction
		instruction_data
		qrcode = RQRCode::QRCode.new("#{@instruction.video_url}")
		png = qrcode.as_png(
          resize_gte_to: false,
          resize_exactly_to: false,
          fill: 'white',
          color: 'black',
          size: 120,
          border_modules: 4,
          module_px_size: 6,
          file: "tmp/github-qrcode.png"
          )
		image "tmp/github-qrcode.png"
	end
	
	def instruction_data
		text "Name: #{@instruction.name}"
		text "Category: #{@instruction.category.name}"
		move_down 20
		text "Tags:"
		tag_list
		
		steps
	end

	def tag_list
		text "#{@instruction.tags.join(',')}"
	end
	
	def steps
		@instruction.steps.each do |s|
			move_down 10
			step(s)
		end
	end

	def step(s)
		text "#{s.number} Step"
		text "#{s.title}"
		text "#{s.description}"
		image open("#{s.image_url}")
	end

end