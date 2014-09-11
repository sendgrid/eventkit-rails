# ==========================================================================
# Dashboard Object 
# ==========================================================================
# A custom object used as the model for the home page.
#

EventKit.DashboardModel = Em.Object.extend({
	recent: null

	today: null

	isPlural: (->
		!(@get('today.length') == 1)
	).property('today')
})