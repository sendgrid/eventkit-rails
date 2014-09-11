# ==========================================================================
# Setup Controller 
# ==========================================================================
# The parent controller of the setup wizard. The setup route has child 
# routes which represent the multiple steps of the wizard.
#

EventKit.SetupController = Em.Controller.extend({

	totalSteps: 3

})