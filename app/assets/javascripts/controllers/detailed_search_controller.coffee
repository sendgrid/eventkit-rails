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
				value = []
				if key == "additional_arguments"
					value.push '"' + filter.key + '":"' + filter.val + '"'
				if key.match /newsletter/g
					value.push '"' + key + '":' + filter.val
				else if key == "event"
					value.push filter.selectedEvent.type
				else
					value.push filter.val

				if key.match /newsletter/g
					if !model.newsletter then model.newsletter = []
					list = model.newsletter
					model.newsletter = list.concat value
				else
					if !model[key] then model[key] = []
					list = model[key]
					model[key] = list.concat value

			@transitionToRoute('detailedSearchResults', {
				queryParams: {
					s: JSON.stringify(model)
					p: 1
				}
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