# ==========================================================================
# Setup Step Three Controller 
# ==========================================================================
# The controller for the third and final step of the setup wizard that 
# shows that the setup is complete.
#

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
		fullURL = protocol + encodeURIComponent(model.get('username')) + ":" + encodeURIComponent(model.get('password')) + "@" + url
		return new Ember.Handlebars.SafeString '<pre><code>' + fullURL + '</code></pre>'
	).property('controllers.setup.model.username', 'controllers.setup.model.password')

	actions: {
		continue: ()->
			u = @get('controllers.setup.model.username')
			p = @get('controllers.setup.model.password')

			self = @

			goToStepThree = ()->
				self.get('controllers.setup.model').reset()
				self.store.find('setting', {
					name: "is_setup"
				}).then((data)->
					setting = data.get('firstObject')
					setting.set('value', '1')
					setting.save().then(()->
						self.transitionToRoute('setupStepThree')
					)
				)

			@store.find('user', {
				username: u
			}).then((setting)->
				if setting and setting.get('length')
					auth = setting.get('firstObject')
					auth.set('username', u)
					auth.set('password', p)
					window.token = auth.get('token')
					auth.save().then(goToStepThree)
				else
					self.store.createRecord('user', {
						username: u
						password: p
					}).save().then((user)->
						window.token = user.get('token')
						goToStepThree()
					)
			)
	}

})