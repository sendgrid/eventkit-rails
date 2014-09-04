# ==========================================================================
# Router
# ==========================================================================
# Lays out all the front end routes for the Ember Framework.
#

EventKit.Router.map ()->

	# HOME ROUTE
	# The main home page/dashboard.
	#=========================================================================#
	@resource('home', {
		path: '/'
	})

	# EVENT ROUTE
	# Displays the information for a specific event.
	#=========================================================================#
	@resource('event', {
		path: '/event/:id'	
	})

	# SETTINGS ROUTE
	# The settings page.
	#=========================================================================#
	@resource('settings')

	# SEARCH RESULTS ROUTE
	# The results page for the wild card search field in the navigation bar.
	#=========================================================================#
	@resource('searchResults', {
        path: "/search/:query/page/:page"
    })

	# DETAILED SEARCH ROUTE
	# The detailed search page that allows a user to specify search terms
	# for specific fields.
	#=========================================================================#
	@resource('detailedSearch')

	# DETAILED SEARCH RESULTS ROUTE
	# The results of the detailed search.
	#=========================================================================#
	@resource('detailedSearchResults', {
		path: "/search/detailed/:query/page/:page"
	})