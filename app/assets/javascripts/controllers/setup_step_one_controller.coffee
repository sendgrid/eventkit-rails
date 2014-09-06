EventKit.SetupStepOneController = Em.Controller.extend({

	needs: ['setup']

	actions: {
		submitBasicAuth: ()->
			if @get('controllers.setup.model.meetsCriteria')
				u = @get('controllers.setup.model.username')
				p = @get('controllers.setup.model.password')

				@get('controllers.setup.model').reset()

				self = @
				@store.find('user', {
					username: u
				}).then((setting)->
					if setting and setting.get('length')
						auth = setting.get('firstObject')
						auth.set('username', u)
						auth.set('password', p)
						auth.save().then(()->
							self.transitionToRoute('setupStepTwo')
						)
					else
						self.store.createRecord('user', {
							username: u
							password: p
						}).save().then(()->
							self.transitionToRoute('setupStepTwo')
						)
				)
	}

})