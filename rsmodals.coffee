'use strict'

angular.module 'rsmodals', [
]
.directive 'modalOpen', ->
	link: (scope, elm, attrs) ->
		# when clicking modal is going to be shown
		elm.click -> scope.$apply ->
			scope.$rsmodal = {}
			scope.$rsmodal[attrs.modalOpen] = true
.directive 'modalShow', ->
	controller: ($scope) ->
		@close = -> delete $scope.$rsmodal
		#coffee-script returns always the last property
		undefined
	link: (scope, elm, attrs, ctrl) ->
		# set default config
		body = attrs.modalBody or 'open-modal'
		container = attrs.container or 'section'
		# make modal invisible from beginning
		do elm.hide
		# watch changes
		scope.$watch '$rsmodal.' + attrs.modalShow, (show) ->
			if show
				# make body overflow hide
				angular.element 'body'
					.addClass body
				# hide other modals if open
				angular.element '[modal-show]'
					.hide()
				# show modal background
				do elm.show
				# show modal container with animation
				elm
					.find container
					.hide()
					.slideDown 'slow'
				return
			# if show false, close modal container with animation
			elm.find container
				.slideUp 'slow', ->
					# after animation finished, close modal background
					do elm.hide
					# check if other visible modals exists
					if not angular
						.element '[modal-show]:visible'
						.length
							# if not, make body overflow show
							angular.element 'body'
								.removeClass body
		# if clicking outside of modal container, modal should disappear
		elm.click -> scope.$apply -> do ctrl.close
		# if clicking on modal container, process of disappearing stops
		elm.find container
			.click (e) -> do e.stopPropagation
.directive 'modalClose', ->
	require: '^modalShow' # directive can only used inside elm with modal-show directive
	link: (scope, elm, attrs, ctrl) ->
		# when clicking modal is going to be closed
		elm.click -> scope.$apply -> do ctrl.close
