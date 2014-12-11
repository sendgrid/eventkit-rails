# ==========================================================================
# Detailed Search Controller 
# ==========================================================================
# The controller for the detailed search page where you can specify
# specific fields to search on.
#

EventKit.DetailedSearchController = Em.ArrayController.extend({

	actions: {

		removeFilter: (sender)->
			@removeObject(sender)

		addFilter: (type)->
			types = []
			for hash in window.EventTypes
				types.push hash

			newFilter = {
 				name: type.name
 				id: type.id
 				time: new Date().getTime()
 				key: ""
 				val: ""
 				events: types
 				selectedEvent: null
 			}

			newFilter[type.id] = "id"

			@addObject(newFilter)

		submitSearch: ()->
			model = {}

			for filter in @get('content')
				key = filter.id
				if key == "additional_arguments"
					value = '"' + key + '":"' + filter.val + '"'
				else if key.match /newsletter/g
					value = '"' + key + '":"' + filter.val + '"'
				else if key == "event"
					value = filter.selectedEvent.type
				else
					value = filter.value
				
				if key.match /newsletter/g
					if !model.newsletter then model.newsletter = []
					model.newsletter.push value
				else
					if !model[key] then model[key] = []
					model[key].push value

			@transitionToRoute('detailedSearchResults', {
				query: encodeURIComponent(JSON.stringify(model))
				page: 1
			})

	}
	
	allFilters: [{
		    name: "Additional Argument"
		    id: "additional_arguments"
		}
		{
		    name: "Attempt"
		    id: "attempt"
		}
		{
		    name: "Category"
		    id: "category"
		}
		{
		    name: "Email"
		    id: "email"
		}
		{
		    name: "Event"
		    id: "event"
		}
		{
		    name: "IP"
		    id: "ip"
		}
		{
		    name: "Newsletter ID"
		    id: "newsletter_id"
		}
		{
		    name: "Newsletter Send ID"
		    id: "newsletter_send_id"
		}
		{
		    name: "Newsletter User List ID"
		    id: "newsletter_list_id"
		}
		{
		    name: "SMTP-ID"
		    id: "smtp-id"
		}
		{
		    name: "Reason"
		    id: "reason"
		}
		{
		    name: "Response"
		    id: "response"
		}
		{
			name: "Message ID"
		}
		{
		    name: "Status"
		    id: "status"
		}
		{
		    name: "Type"
		    id: "type"
		}
		{
		    name: "URL"
		    id: "url"
		}
		{
		    name: "User Agent"
		    id: "useragent"
		}]

})