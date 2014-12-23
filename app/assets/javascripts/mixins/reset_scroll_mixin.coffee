EventKit.ResetScroll = Ember.Mixin.create {
	activate: ()->
		@_super()
		unless $('.navbar-toggle').css('display') == 'none'
			$(".navbar-ex1-collapse").collapse('hide')
		window.scrollTo 0, 0
}