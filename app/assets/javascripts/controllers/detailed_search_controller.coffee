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
			newFilter = {
 				name: type.name
 				id: type.id
 				time: new Date().getTime()
 				name_key: type.id + "_key"
 				name_val: type.id + "_value"
 				key: ""
 				val: ""
 			}

			newFilter[type.id] = "id"

			@addObject(newFilter)

		submitSearch: ()->
			params = {}
			$("#detailedSearchParams :input").each(()->
				if (@type == 'button') then return
				if (!params[@name]) then params[@name] = []
				params[@name].push $(@).val()
			)

			model = {}

			for key, value of params
				if key == "additional_arguments_value"
					continue
				else if key == "additional_arguments_key"
					if !model.additional_arguments then model.additional_arguments = []
					value.forEach((value, index, array)->
						model.additional_arguments.push '"' + value + '":"' + params.additional_arguments_value[index] + '"'
					)
				else if key.match(/newsletter/g)
					if !model.newsletter then model.newsletter = []
					value.forEach((value, index, array)->
						model.newsletter.push '"' + key + '":"' + value + '"'
					)
				else if key == "dateStart" || key == "dateEnd"
					date = new Date(value)
					milliseconds = date.getTime()
					mod = milliseconds % 1000
					unix = (milliseconds - mod) / 1000
					model[key] = unix
				else
					model[key] = value

			@transitionTo('detailedSearchResults', {
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