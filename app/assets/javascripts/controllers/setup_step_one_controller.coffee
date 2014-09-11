# ==========================================================================
# Setup Step One Controller 
# ==========================================================================
# The controller for the first step of the setup wizard that sets up
# a username and password.
#

EventKit.SetupStepOneController = Em.Controller.extend({

	needs: ['setup']

	actions: {
		submitBasicAuth: ()->
			if @get('controllers.setup.model.meetsCriteria')
				u = @get('controllers.setup.model.username')
				p = @get('controllers.setup.model.password')

				self = @
				@store.find('user', {
					username: u
				}).then((setting)->
					if setting and setting.get('length')
						auth = setting.get('firstObject')
						auth.set('username', u)
						auth.set('password', p)
						localStorage['token'] = auth.get('token')
						auth.save().then(()->
							self.transitionToRoute('setupStepTwo')
						)
					else
						self.store.createRecord('user', {
							username: u
							password: p
						}).save().then((user)->
							localStorage['token'] = user.get('token')
							self.transitionToRoute('setupStepTwo')
						)
				)
	}

})