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

	isHttps: (->
		if window.location.protocol.match(/https/gi) then true else false
	).property()

	passwordMatches: (->
		if !@get('password').length and !@get('confirmPassword').length
			return true
		(@get('password') == @get('confirmPassword'))
	).property('password', 'confirmPassword')

	meetsCriteria: (->
		(@get('passwordMatches') and @get('username').replace(///\s///g,"").length and @get('password').length and @get('confirmPassword').length)
	).property('username', 'passwordMatches')

	reset: ()->
		@set('username', '')
		@set('password', '')
		@set('confirmPassword', '')
})