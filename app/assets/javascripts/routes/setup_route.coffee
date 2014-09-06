EventKit.SetupRoute = Em.Route.extend({

	model: ()->
		EventKit.HttpBasicAuth.create()

	activate: ()->
		self = @
		@store.find('setting', {
			name: 'is_setup'
		}).then((setup)->
			if setup and setup.get('length')
				if (setup.get('firstObject.value') * 1)
					self.transitionTo('home')
		)

})



EventKit.HttpBasicAuth = Em.Object.extend({
	username: ""
	password: ""
	confirmPassword: ""

	passwordMatches: (->
		if !@get('password').length || !@get('confirmPassword').length
			return true
		(@get('password') == @get('confirmPassword'))
	).property('password', 'confirmPassword')

	meetsCriteria: (->
		(@get('passwordMatches') and @get('username').length and @get('password').length and @get('confirmPassword').length)
	).property('username', 'passwordMatches')

	reset: ()->
		@set('username', '')
		@set('password', '')
		@set('confirmPassword', '')
})