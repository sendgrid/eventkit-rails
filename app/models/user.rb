class User < ActiveRecord::Base

	def issue_token
		now = Time.now.to_i
		token = self.token
		if now > self.token_expires then
			self.token = loop do
				token = SecureRandom.urlsafe_base64(nil, false)
				break token unless (User.exists?(token: token))
			end
			self.token = token
			self.token_expires = now + (24 * 60 * 60)
		end
		self.save
	end

end
