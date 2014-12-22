# ==========================================================================
# User Model
# ==========================================================================
# The frontend model for the user table.
#

EventKit.User = DS.Model.extend({
	username: DS.attr()
	password: DS.attr()
	permissions: DS.attr()
	token: DS.attr()

	editing: false

	update: EventKit.HttpBasicAuth.create()

	canView: ((key, value, previousValue) ->
		perms = @get('permissions')
		level = Permissions.VIEW

		if arguments.length > 1
			if value
				perms |= level
			else
				perms ^= level

			@set('permissions', perms)

		if perms & level then true else false
	).property('permissions')

	canEdit: ((key, value, previousValue) ->
		perms = @get('permissions')
		level = Permissions.EDIT

		if arguments.length > 1
			if value
				perms |= level
			else
				perms ^= level

			@set('permissions', perms)

		if perms & level then true else false
	).property('permissions')

	canDownload: ((key, value, previousValue) ->
		perms = @get('permissions')
		level = Permissions.DOWNLOAD

		if arguments.length > 1
			if value
				perms |= level
			else
				perms ^= level

			@set('permissions', perms)
	
		if perms & level then true else false
	).property('permissions')

	canPost: ((key, value, previousValue) ->
		perms = @get('permissions')
		level = Permissions.POST

		if arguments.length > 1
			if value
				perms |= level
			else
				perms ^= level

			@set('permissions', perms)

		if perms & level then true else false
	).property('permissions')

})