EventKit.WildcardSearchController = Em.Controller.extend({

	query: ''

	actions: {

		search: ()->
			@transitionToRoute('searchResults', {
				query: encodeURIComponent(@get('query'))
				page: 1
			})

	}

})