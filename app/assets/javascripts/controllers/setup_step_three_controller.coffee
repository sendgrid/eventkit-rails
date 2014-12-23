# ==========================================================================
# Setup Step Two Controller 
# ==========================================================================
# The controller for the second step of the setup wizard that provides steps
# to setup the Event Notification app.
#

EventKit.SetupStepThreeController = Em.Controller.extend({

	needs: ['setup']

	actions: {
		goToDashboard: ()->
			window.location.reload()
	}

})