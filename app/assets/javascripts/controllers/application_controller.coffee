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
		goToSetup = ()->
			self.set('isInSetup', true)
			$('body').css('paddingTop', '0px').removeClass('standalone')
			self.transitionToRoute('setupStepOne')
		if model and model.get('length')
			if !(model.get('firstObject.value') * 1) then goToSetup()
		else 
			self.store.createRecord('setting', {
				name: "is_setup"
				value: "0"
				visible: 0
			}).save()
			goToSetup()

		if window.token and window.token.length
			@set('user', @store.find("user", {
				token: window.token
			}).then((users)->
				if users.get('length')
					self.set('user', users.get('firstObject'))
			))
	).observes('model')

	isInSetup: false
	user: null

})