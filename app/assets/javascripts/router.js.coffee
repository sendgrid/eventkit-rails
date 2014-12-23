# ==========================================================================
# Router
# ==========================================================================
# Lays out all the front end routes for the Ember Framework.
#

EventKit.Router.map ()->

	# HOME ROUTE
	# The main home page/dashboard.
	#=========================================================================#
	@resource 'home', {
		path: '/'
	}

	# EVENT ROUTE
	# Displays the information for a specific event.
	#=========================================================================#
	@resource 'event', {
		path: '/event/:id'	
	}

	# SETTINGS ROUTE
	# The settings page.
	#=========================================================================#
	@resource 'settings', {
		path: '/settings'
	}

	# USER SETTINGS ROUTE
	# The page for editing an existing user (change permissions/password)
	#=========================================================================#
	@resource 'user', {
		path: '/settings/user/:id'
	}

	# SEARCH RESULTS ROUTE
	# The results page for the wild card search field in the navigation bar.
	#=========================================================================#
	@resource 'searchResults', {
        path: '/search/:query/page/:page'
    }

	# DETAILED SEARCH ROUTE
	# The detailed search page that allows a user to specify search terms
	# for specific fields.
	#=========================================================================#
	@resource 'detailedSearch', {
		path: '/search/detailed'
	}

	# DETAILED SEARCH RESULTS ROUTE
	# The results of the detailed search.
	#=========================================================================#
	@resource 'detailedSearchResults', {
		path: '/search/detailed/results'
	}

	# SETUP ROUTE
	# The setup wizard that gets run during the first load.
	#=========================================================================#
	@resource 'setup', {
			path: '/setup/step'
		}, ()->
			@resource 'setupStepOne', {
				path: '/1'	
			}

			@resource 'setupStepTwo', {
				path: '/2'
			}

			@resource 'setupStepThree', {
				path: '/3'
			}

	# 404 NOT FOUND
	# Used if the user goes to a route that doesn't exist.
	#=========================================================================#
	@resource 'notFound', {
		path: '*path'
	}