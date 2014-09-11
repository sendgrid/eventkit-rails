# ==========================================================================
# Detailed Search Results Controller 
# ==========================================================================
# The controller for the detailed search results view.
#

EventKit.DetailedSearchResultsController = Em.Controller.extend({

	modelLoaded: false

	modelDidChange: (->
		@set('modelLoaded', true)
	).observes('model')

})