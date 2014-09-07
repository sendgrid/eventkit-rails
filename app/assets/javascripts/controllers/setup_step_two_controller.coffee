EventKit.SetupStepTwoController = Em.Controller.extend({

	needs: ['setup']

	isSecure: (->
		if window.location.protocol.match(/https/gi) then true else false
	).property()

	endpoint: (->
		protocol = window.location.protocol + "//"
		hash = window.location.hash
		url = window.location.href.replace(protocol, "").replace(hash, "")
		model = @get('controllers.setup.model')
		protocol + model.get('username') + ":" + model.get('password') + "@" + url
	).property('controllers.setup.model.username', 'controllers.setup.model.password')

	actions: {
		continue: ()->
			@get('controllers.setup.model').reset()
			self = @
			@store.find('setting', {
				name: "is_setup"
			}).then((data)->
				setting = data.get('firstObject')
				setting.set('value', '1')
				setting.save().then(()->
					self.transitionToRoute('setupStepThree')
				)
			)
	}

})