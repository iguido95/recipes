module ApplicationHelper
	def gravatar_for(chef, options= { size: 80 })
		name = chef.chefname
		email = chef.email.downcase
		
		gravatar_id = Digest::MD5::hexdigest(email)
		size = options[:size]
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
		
		return image_tag(gravatar_url, alt: name, class: "gravatar")
	end
end
