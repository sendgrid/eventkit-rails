# ==========================================================================
# Application Controller 
# ==========================================================================
# Contains controller actions for the navigation bar.
#

EventKit.ApplicationController = Em.Controller.extend({

	query: ''

	actions: {

		search: ()->
			@transitionToRoute('searchResults', {
				query: encodeURIComponent(@get('query'))
				page: 1
			})

	}

})