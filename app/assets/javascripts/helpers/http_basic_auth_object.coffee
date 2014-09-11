# ==========================================================================
# HTTP Basic Auth Object 
# ==========================================================================
# A custom object used for creating new credentials. It has fields to hold
# the values and also computed properties to make sure passwords match.
#

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