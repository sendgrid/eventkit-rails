# ==========================================================================
# Application Controller 
# ==========================================================================
# Contains controller actions for the navigation bar.
#

EventKit.ApplicationController = Em.Controller.extend({

	query: ''

	actions: {

		search: ()->
			@transitionToRoute('search', {
				query: @get('query')
				page: 1
			})

	}

})