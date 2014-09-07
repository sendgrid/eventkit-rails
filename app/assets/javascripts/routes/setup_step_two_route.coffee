EventKit.SetupStepTwoRoute = Em.Route.extend({

	setupController: (controller, model)->
		if !controller.get('controllers.setup.model.meetsCriteria')
			@transitionTo('setupStepOne')

})