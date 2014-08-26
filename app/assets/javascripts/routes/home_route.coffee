EventKit.HomeRoute = Em.Route.extend({
	model: ()->
		now = new Date()
		yesterday = Math.floor(now.getTime() / 1000) - (24 * 60 * 60)
		Em.Object.create({
			recent: @store.find('event', {
					limit: 10
					offset: 0
					descending: true
				})
		})
})