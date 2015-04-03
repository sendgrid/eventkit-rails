# ==========================================================================
# Search Results Route
# ==========================================================================
# Performs the wild card search and returns the results as the results as 
# the model for the Search Results Controller.
#

EventKit.SearchResultsRoute = Em.Route.extend EventKit.ResetScroll, {

	fetch: (query, page)->
		limit = 10
		offset = (page - 1) * limit
		if offset then offset++

		q = decodeURIComponent(query)
		p = page * 1

		@store.find('event', {
			limit: limit
			offset: offset
			like: true
			raw: q
			descending: 1
			sortby: 'timestamp'
		}).then((results)->
			total = results.get("meta.total")
			totalPages = ((limit - (total % limit)) + total) / limit

			pagesArray = [{
				query: query
				page: 1
				display: new Ember.Handlebars.SafeString("&laquo;")
			}]

			padding = 3
			pageStart = p - padding
			if pageStart < 1 then pageStart = 1

			pageEnd = pageStart + (padding * 2)
			if pageEnd > totalPages then pageEnd = totalPages

			for i in [pageStart..pageEnd]
				pagesArray.push {
					query: query
					page: i
					display: i
				}

			pagesArray.push {
				query: query
				page: totalPages
				display: new Ember.Handlebars.SafeString("&raquo;")
			}

			{
				results: results
				query: q
				csv: "/api/v1/events.csv?" + jQuery.param({
					like: true
					raw: q
					descending: 1
					sortby: 'timestamp'
					token: window.token
				})
				total: total
				pages: pagesArray
			}
		)

	model: (params)->
		@fetch(params.query, params.page)

	setupController: (controller, model)->
		@_super(controller, model)
		if !model.results
			@fetch(model.query, model.page).then((data)->
				controller.set('model', data)
			)

}