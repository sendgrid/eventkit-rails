class User < ActiveRecord::Base
  def issue_token
    now = Time.now.to_i
    token = self.token
    if now > token_expires
      self.token = loop do
        token = SecureRandom.urlsafe_base64(nil, false)
        break token unless User.exists?(token: token)
      end
      self.token = token
      renew_expiration
    end
    save
  end

  def renew_expiration
    days = 7
    now = Time.now.to_i
    self.token_expires = now + (days * 24 * 60 * 60)
    save
  end

  def is_token_expired
    now = Time.now.to_i
    now > token_expires
  end
end
