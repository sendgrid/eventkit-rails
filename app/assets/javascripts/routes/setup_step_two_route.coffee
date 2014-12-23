# ==========================================================================
# Setup Step Two Route 
# ==========================================================================
# Checks with the parent Setup route to see if step 1 was completed. If not,
# it redirects to the first step.
#

EventKit.SetupStepTwoRoute = Em.Route.extend EventKit.ResetScroll, {

	setupController: (controller, model)->
		if !controller.get('controllers.setup.model.meetsCriteria')
			@transitionTo('setupStepOne')

}