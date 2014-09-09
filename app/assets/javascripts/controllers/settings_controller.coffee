EventKit.SettingsController = Em.Controller.extend({

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

	users: null
	loadedUsers: false
	editAccessDisabled: (->
		if !@get('users') then return true
		i = 0
		@get('users').forEach((user)->
			if user.get('canEdit') and user.get('canView') then i++
		)
		if i > 1 then false else true
	).property('users.@each.permissions')

	autodeleteSubtext: (->
		if @get('autodeleteSelectedValue.value') == 0
			'WARNING! Never deleting events from your database could result in a very large database which might impact performance.  If you\'re using Heroku, there might be a limit on the number of events your database can hold, and might require upgrading your database plan.'
		else
			'Please note that if you\'re using Heroku, there may be limitations on the number of events your database can hold. See your Heroku account for more information.'
	).property('autodeleteSelectedValue')

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
	}

})