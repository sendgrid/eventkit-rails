window.Permissions = {
	VIEW: 1 << 0
	DOWNLOAD: 1 << 1
	POST: 1 << 2
	EDIT: 1 << 3
}


EventKit.HttpBasicAuth = Em.Object.extend({
	username: ""
	password: ""
	confirmPassword: ""

	passwordMatches: (->
		if !@get('password').length and !@get('confirmPassword').length
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