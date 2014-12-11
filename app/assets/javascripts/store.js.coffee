EventKit.ApplicationStore = DS.Store.extend()

# Override the default adapter with the `DS.ActiveModelAdapter` which
# is built to work nicely with the ActiveModel::Serializers gem.
EventKit.ApplicationAdapter = DS.ActiveModelAdapter.extend({
	namespace: 'api/v1'
	ajax: (url, type, hash) ->
		hash = hash || {};
		hash.beforeSend = (xhr)->
			xhr.setRequestHeader("X-Requesting-Application", "EVENTKIT-RAILS");
			if window.token
				xhr.setRequestHeader('X-Auth-Token', window.token)
		@_super(url, type, hash);
})
