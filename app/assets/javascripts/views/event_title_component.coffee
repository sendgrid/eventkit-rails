# ==========================================================================
# Event Title Component 
# ==========================================================================
# A component that displays an event name with the appropriate color.
#

EventKit.EventTitleComponent = Em.Component.extend({
	event: ''

	eventDisplayName: (->
		events = {}

		for hash in window.EventTypes
			events[hash.type] = hash.name

		events[@get('event')]
	).property('event')

	tagName: 'span'

	classNameBindings: ['event']
})