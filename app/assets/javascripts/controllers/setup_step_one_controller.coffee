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
				@transitionToRoute('setupStepTwo')
	}

})