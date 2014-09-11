# ==========================================================================
# Application Controller 
# ==========================================================================
# Contains controller actions for the navigation bar. This controller is a
# subclass of EventKit.WildcardSearchController, which implements the 
# wild card search actions.
#

EventKit.ApplicationController = EventKit.WildcardSearchController.extend({

	modelDidChange: (->
		self = @
		model = @get('model')
		if model and model.get('length')
			if !(model.get('firstObject.value') * 1) then self.transitionToRoute('setupStepOne')
		else 
			self.store.createRecord('setting', {
				name: "is_setup"
				value: "0"
				visible: 0
			}).save()
			self.transitionToRoute('setupStepOne')

		if localStorage['token'] and localStorage['token'].length
			@set('user', @store.find("user", {
				token: localStorage['token']
			}).then((users)->
				if users.get('length')
					self.set('user', users.get('firstObject'))
			))
	).observes('model')

	user: null

})