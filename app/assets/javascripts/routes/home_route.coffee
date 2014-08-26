EventKit.HomeRoute = Em.Route.extend({
	model: ()->
		now = new Date()
		yesterday = Math.floor(now.getTime() / 1000) - (24 * 60 * 60)
		EventKit.DashboardModel.create({
			recent: @store.find('event', {
				limit: 10
				offset: 0
				descending: 1
				sortby: 'timestamp'
			})

			today: @store.find('event', {
				since: yesterday
			})
		})
})

EventKit.DashboardModel = Em.Object.extend({
	recent: null

	today: null

	isPlural: (->
		!(@get('today.length') == 1)
	).property('today')
})