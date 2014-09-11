# ==========================================================================
# Settings Controller 
# ==========================================================================
# The controller for the settings page.
#

EventKit.SettingsController = Em.Controller.extend({

	modelDidChange: (->
		self = @

		# Get the Autodelete Setting
		@store.find('setting', {
			name: "autodelete_time"
		}).then((results)->
			setting = results.get('firstObject')
			value = setting.get('value') * 1
			self.set('autodeleteSelectedValue', self.get('autodelete')[value])
		)

		# Get the user list
		@store.find('user').then(
			(users)->
				self.set('loadedUsers', true)
				if users then self.set('users', users)
				users
			(response)->
				self.set('loadedUsers', true)
		)
	).observes('model')


	# AUTO DELETE SETTING
	#=========================================================================#

	autodelete: [
		{
			label: "Never"
			value: 0
		}
		{
			label: "1 month"
			value: 1
		}
		{
			label: "2 months"
			value: 2
		}
		{
			label: "3 months"
			value: 3
		}
		{
			label: "4 months"
			value: 4
		}
		{
			label: "5 months"
			value: 5
		}
		{
			label: "6 months"
			value: 6
		}
		{
			label: "7 months"
			value: 7
		}
		{
			label: "8 months"
			value: 8
		}
		{
			label: "9 months"
			value: 9
		}
		{
			label: "10 months"
			value: 10
		}
		{
			label: "11 months"
			value: 11
		}
		{
			label: "12 months"
			value: 12
		}
	]

	autodeleteSelectedValue: null

	autodeleteSubtext: (->
		if @get('autodeleteSelectedValue.value') == 0
			'WARNING! Never deleting events from your database could result in a very large database which might impact performance.  If you\'re using Heroku, there might be a limit on the number of events your database can hold, and might require upgrading your database plan.'
		else
			'Please note that if you\'re using Heroku, there may be limitations on the number of events your database can hold. See your Heroku account for more information.'
	).property('autodeleteSelectedValue')


	# USERS
	#=========================================================================#

	users: null
	loadedUsers: false
	editAccessDisabled: (->
		if !@get('users') then return true
		i = 0
		@get('users').forEach((user)->
			if user.get('canEdit') and user.get('canView') then i++
		)
		if i > 0 then false else true
	).property('users.@each.permissions')

	showAddUser: false
	newUser: EventKit.HttpBasicAuth.create()

	# ACTIONS
	#=========================================================================#

	actions: {
		save: ()->
			self = @
			@store.find('setting', {
				name: "autodelete_time"
			}).then((results)->
				setting = results.get('firstObject')
				setting.set('value', self.get('autodeleteSelectedValue.value'))
				setting.save().then(()->
					alert 'Your changes have been saved!'
				)
			)

			@get('users').forEach((user)->
				if user.get('isDirty') then user.save()
			)

		toggleAddUser: ()->
			@get('newUser').reset()
			@set('showAddUser', !@get('showAddUser'))

		addNewUser: ()->
			if @get('newUser.meetsCriteria')
				u = @get('newUser.username')
				p = @get('newUser.password')

				self = @
				@store.createRecord('user', {
					username: u
					password: p
				}).save().then((user)->
					self.set('showAddUser', false)
					self.set('model', new Date())
				)

		editUser: (user)->
			user.get('update').reset()
			user.set('editing', !user.get('editing'))

		updateUser: (user)->
			self = @
			if user.get('update.passwordMatches')
				if user.get('update.password').length and user.get('update.confirmPassword').length
					user.set('password', user.get('update.password'))

				user.save().then((user)->
					self.set('model', new Date())
					user.get('update').reset()
					user.set('editing', false)
					alert "User updates saved!"
				)
			else
				alert "The passwords don't match!"

		deleteUser: (user)->
			if confirm "Are you sure you want to delete the user \"" + user.get('username') + "\"?"
				self = @
				user.destroyRecord().then(()->
					self.set('model', new Date())
				)

	}

})