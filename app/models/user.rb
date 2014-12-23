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
			self.renew_expiration
		end
		self.save
	end

	def renew_expiration
		days = 7
		now = Time.now.to_i
		self.token_expires = now + (days * 24 * 60 * 60)
		self.save
	end

	def is_token_expired
		now = Time.now.to_i
		return now > self.token_expires
	end

end
