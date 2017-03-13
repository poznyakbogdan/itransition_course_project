class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :step
	validates :content, presence: true

end
