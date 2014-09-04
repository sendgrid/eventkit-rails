EventKit.DetailedSearchResultsRoute = Em.Route.extend({

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
			detailed: q
			descending: 1
			sortby: 'timestamp'
		}).then((results)->
			total = results.get("meta.total")
			totalPages = ((limit - (total % limit)) + total) / limit

			pagesArray = [{
				query: query
				page: 1
				display: new Handlebars.SafeString("&laquo;")
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
				display: new Handlebars.SafeString("&raquo;")
			}

			{
				results: results
				query: q
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

})