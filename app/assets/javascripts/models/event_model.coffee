EventKit.Event = DS.Model.extend({
	timestamp: DS.attr()
	event: DS.attr()
	email: DS.attr()
	"smtp-id": DS.attr()
	sg_event_id: DS.attr()
	sg_message_id: DS.attr()
	category: DS.attr()
	newsletter: DS.attr()
	response: DS.attr()
	reason: DS.attr()
	ip: DS.attr()
	useragent: DS.attr()
	attempt: DS.attr()
	status: DS.attr()
	type_id: DS.attr()
	url: DS.attr()
	additional_arguments: DS.attr()
	event_post_timestamp: DS.attr()
	raw: DS.attr()

	hasAdditionalArguments: (->
		str = @get('additional_arguments')
		args = JSON.parse(str)
		i = 0
		for key, value of args
			i++
		i > 0
	).property('additional_arguments')

	additionalArgumentList: (->
		str = @get('additional_arguments')
		args = JSON.parse(str)
		list = []

		for key, value of args
			list.push {
				key: key
				value: value
			}

		list
	).property('additional_arguments')
})