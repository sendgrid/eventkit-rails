# ==========================================================================
# Wildcard Search Controller 
# ==========================================================================
# A controller subclass that specifies actions used to make a wild card
# search. The main application controller and home controller subclass this
# controller, as they both have fields to make a wild card search.
#

EventKit.WildcardSearchController = Em.Controller.extend({

	query: ''

	actions: {

		search: ()->
			$(".navbar-collapse").collapse("hide")
			@transitionToRoute('searchResults', {
				query: encodeURIComponent(@get('query'))
				page: 1
			})
			@set 'query', ''

	}

})