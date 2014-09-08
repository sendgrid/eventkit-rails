class UserSerializer < ApplicationSerializer
	# Included attributes
	attributes :id, :username, :permissions, :token
end
