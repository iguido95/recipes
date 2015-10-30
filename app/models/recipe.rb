class Recipe < ActiveRecord::Base
	belongs_to :chef	
	has_many :likes, dependent: :destroy

	has_many :recipe_styles, dependent: :destroy
	has_many :styles, through: :recipe_styles

	has_many :recipe_ingredients, dependent: :destroy
	has_many :ingredients, through: :recipe_ingredients
	
	validates :chef_id, presence: true
	validates :name, presence: true, length: { in: 5..100 }
	validates :summary, presence: true, length: { in: 10..150 }
	validates :description, presence: true, length: { in: 20..500 }
	
	mount_uploader :picture, PictureUploader
	validate :picture_size
	
	def likes_total
		self.likes.where(like: true).size
	end
	
	def dislikes_total
		self.likes.where(like: false).size
	end	
	
	def net_likes
		net_value = (self.likes_total - self.dislikes_total)
		if net_value >= 0 
			return "+#{net_value}"
		else 
			return net_value
		end
	end		
			
		
	private 
		def picture_size
			if picture.size > 5.megabytes
				errors.add(:picture, "should be less then 5 MB")
			end	
		end	
			
end