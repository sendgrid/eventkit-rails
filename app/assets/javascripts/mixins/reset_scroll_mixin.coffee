EventKit.ResetScroll = Ember.Mixin.create {
	activate: ()->
		@_super()
		window.scrollTo 0, 0
}