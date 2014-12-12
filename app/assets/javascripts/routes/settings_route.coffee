# ==========================================================================
# Settings Route 
# ==========================================================================
# Provides the model for the Search Controller. You'll note that the model
# being returned is just a new Date object. This is because the controller
# has observes on the model that refetches setting info.  By returning
# a new date object, those settings get fetched each time the settings 
# page is loaded.
#

EventKit.SettingsRoute = Em.Route.extend EventKit.ResetScroll, {

	model: ()->
		new Date()

}