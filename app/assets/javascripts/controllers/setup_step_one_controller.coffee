EventKit.SetupStepOneController = Em.Controller.extend({

	needs: ['setup']

	actions: {
		submitBasicAuth: ()->
			if @get('controllers.setup.model.meetsCriteria')
				u = @get('controllers.setup.model.username')
				p = @get('controllers.setup.model.password')
				hash = {
					u: u
					p: p
				}
				value = JSON.stringify(hash)

				@get('controllers.setup.model').reset()

				self = @
				@store.find('setting', {
					name: 'http_basic'
				}).then((setting)->
					if setting and setting.get('length')
						auth = setting.get('firstObject')
						auth.set('value', value)
						auth.save().then(()->
							self.transitionToRoute('setupStepTwo')
						)
					else
						self.store.createRecord('setting', {
							name: 'http_basic'
							value: value
							visible: 0
						}).save().then(()->
							self.transitionToRoute('setupStepTwo')
						)
				)
	}

})