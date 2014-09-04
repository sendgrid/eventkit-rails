EventKit.DetailedSearchResultsController = Em.Controller.extend({

	modelLoaded: false

	modelDidChange: (->
		@set('modelLoaded', true)
	).observes('model')

})