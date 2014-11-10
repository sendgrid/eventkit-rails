# ==========================================================================
# Event Title Component 
# ==========================================================================
# A component that displays an event name with the appropriate color.
#

EventKit.EventTitleComponent = Em.Component.extend({
	event: ''

	eventDisplayName: (->
			events = {
				bounce: "Bounce"
				click: "Click"
				deferred: "Deferred"
				delivered: "Delivered"
				dropped: "Dropped"
				open: "Open"
				processed: "Processed"
				spamreport: "Spam Report"
				unsubscribe: "Unsubscribe",
				group_unsubscribe: "Group Unsubscribe",
				group_resubscribe: "Group Resubscribe"
			}
			events[@get('event')]
		).property('event')

	tagName: 'span'

	classNameBindings: ['event']
})