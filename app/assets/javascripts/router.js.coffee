# For more information see: http://emberjs.com/guides/routing/

EventKit.Router.map ()->
	@resource('home', {
		path: '/'
	})

	@resource('event', {
		path: '/event/:id'	
	})

	@resource('settings')

	@resource('search', {
        path: "/search/:query/page/:page"
    })

	@resource('detailedSearch')