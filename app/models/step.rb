
class Step < ApplicationRecord
	belongs_to :instruction
	mount_uploader :image, ImageUploader
end
