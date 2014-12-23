# ==========================================================================
# Home Route
# ==========================================================================
# Provides the model for the home dashboard.
#

EventKit.HomeRoute = Em.Route.extend EventKit.ResetScroll, {
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
}