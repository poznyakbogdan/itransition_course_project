
class Step < ApplicationRecord
	belongs_to :instruction
	has_many :comments, dependent: :destroy

	mount_uploader :image, ImageUploader
end
