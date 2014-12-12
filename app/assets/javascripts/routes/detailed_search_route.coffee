# ==========================================================================
# Detailed Search Route 
# ==========================================================================
# The route for the detailed search page (where you specify search 
# criteria).  The model that gets sent to the controller is an array of
# search filters.
#

EventKit.DetailedSearchRoute = Em.Route.extend EventKit.ResetScroll, {

	model: ()->
		searchFilters

}

searchFilters = []