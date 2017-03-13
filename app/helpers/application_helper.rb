module ApplicationHelper
	def paginate(collection, params= {})
    will_paginate collection, params.merge(:renderer => RemoteLinkPaginationHelper::LinkRenderer)
  end

  def instruction_image_preview(instruction)
  	validation_string = /([a-z\-_0-9\/\:\.]*\.(jpg|jpeg|png|gif))/
  	default_image = "manuals.jpg"
  	if !instruction.steps.empty? && /([a-z\-_0-9\/\:\.]*\.(jpg|jpeg|png|gif))/ =~ instruction.steps.first.image_url.to_s
 			instruction.steps.first.image_url
 		else
 			default_image
 		end
  end

  def youtube_embded(youtube_url)
		youtube_id = youtube_url.split("=").last
		content_tag(:iframe, nil, src: "//www.youtube.com/embed/#{youtube_id}", class: "instruction-video", frameborder: 0)
	end

end
