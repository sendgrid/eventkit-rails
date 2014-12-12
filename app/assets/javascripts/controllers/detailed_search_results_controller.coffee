# ==========================================================================
# Detailed Search Results Controller 
# ==========================================================================
# The controller for the detailed search results view.
#

EventKit.DetailedSearchResultsController = Em.Controller.extend({

	# URL Paramters
	# s = search filters
	# p = page number
	queryParams: ['s','p']

	modelLoaded: false

	modelDidChange: (->
		@set('modelLoaded', true)
	).observes('model')

})