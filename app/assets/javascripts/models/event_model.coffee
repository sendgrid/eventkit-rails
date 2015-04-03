# ==========================================================================
# Event Model
# ==========================================================================
# The frontend model for the event table.
# 

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
	asm_group_id: DS.attr()
	additional_arguments: DS.attr()
	event_post_timestamp: DS.attr()
	raw: DS.attr()



	# COMPUTED PROPERTIES
	#=========================================================================#
	rawCodeBlock: (->
		raw = ""

		if @get('raw')
			rawObject = JSON.parse @get('raw')
			raw = JSON.stringify rawObject, null, 2

		return new Ember.Handlebars.SafeString("<pre><code>" + raw + "</code></pre>")
	).property('raw')

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

		if args
			for key, value of args
				list.push {
					key: key
					value: value
				}

		list
	).property('additional_arguments')

	categoryList: (->
		try 
			JSON.parse(@get('category'))
		catch error
			[@get('category')]
	).property('category')

	newsletterList: (->
		JSON.parse(@get('newsletter'))
	).property('newsletter')

	dropExplanation: (->
		if @get('reason')
			if @get('event') == 'dropped'
				descriptions = {
					bounce: "This email was dropped because \"__EMAIL__\" is on your bounce list.  To continue sending to this address, go to <a href=\"http://sendgrid.com/bounces\">http://sendgrid.com/bounces</a> and delete it from the list.",
					unsubscribe: "This email was dropped because \"__EMAIL__\" is on your unsubscribe list.  To continue sending to this address, go to <a href=\"http://sendgrid.com/unsubscribes\">http://sendgrid.com/unsubscribes</a> and delete it from the list.",
					invalid: "This email was dropped because \"__EMAIL__\" is an invalid email address.  See your invalid email list at <a href=\"http://sendgrid.com/invalidEmail\">http://sendgrid.com/invalidEmail</a> for more info.",
					spam: "This email was dropped because \"__EMAIL__\" reported one of your previous messages as spam, and got added to your spam report list.  To continue sending to this address, go to <a href=\"http://sendgrid.com/spamReports\">http://sendgrid.com/spamReports</a> and delete it from the list.",
					quota: "This email was dropped because the amount of recipients specified in the message exceeded the number of credits remaining on your account at the time of the send. See the <a href=\"https://sendgrid.com/docs/User_Guide/sending_practices.html\" target=\"_blank\">Sending Practices and Limitations</a> section of SendGrid's docs for more info."
				}

				if @get('reason').match(/smtpapi/gi)
					reason = "This email was dropped because the message contained an invalid X-SMTPAPI header.  An email was sent to the \"From\" address on the message with more details.  You can also use SendGrid's <a href=\"https://sendgrid.com/docs/Utilities/smtpapi_validator.html\" target=\"_blank\">SMTPAPI Header Validator</a> to help troubleshoot."
				else
					for type, message of descriptions
						regex = new RegExp(type, "gi");
						if @get('reason').match(regex)
							reason = descriptions[type].replace('__EMAIL__', @get('email'));
		
		if reason then new Ember.Handlebars.SafeString(reason) else reason
	).property('event')
})