# ==========================================================================
# Format Date Helper 
# ==========================================================================
# A custom handlebar helper to format a unix timestamp to a localized 
# string.
#

Ember.Handlebars.helper('format-date', (unix)->
	date = new Date(unix * 1000)
	date.toLocaleDateString() + " at " + date.toLocaleTimeString()
)