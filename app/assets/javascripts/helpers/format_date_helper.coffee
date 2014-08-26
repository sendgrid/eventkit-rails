Ember.Handlebars.helper('format-date', (unix)->
	date = new Date(unix * 1000)
	date.toLocaleDateString() + " at " + date.toLocaleTimeString()
)