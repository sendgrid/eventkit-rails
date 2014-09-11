# ==========================================================================
# Setting Model 
# ==========================================================================
# The frontend model for the setting table.
#

EventKit.Setting = DS.Model.extend({
	name: DS.attr()
	value: DS.attr()
	visible: DS.attr()
})