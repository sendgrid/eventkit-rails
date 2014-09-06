# ==========================================================================
# Active Model Serializer 
# ==========================================================================
# This file sets up the ActiveModel Serializer to include the ids of 
# relationships.
#
# This file should be stored at:
#     /config/initializers/active_model_serializer.rb
#

ActiveModel::Serializer.setup do |config|
	config.embed = :ids
	config.embed_in_root = true
end