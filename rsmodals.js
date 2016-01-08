// Generated by CoffeeScript 1.10.0
(function() {
  'use strict';
  angular.module('rsmodals', []).directive('modalOpen', function() {
    return {
      link: function(scope, elm, attrs) {
        return elm.click(function() {
          return scope.$apply(function() {
            scope.$rsmodal = {};
            return scope.$rsmodal[attrs.modalOpen] = true;
          });
        });
      }
    };
  }).directive('modalShow', function() {
    return {
      controller: function($scope) {
        this.close = function() {
          return delete $scope.$rsmodal;
        };
        return void 0;
      },
      link: function(scope, elm, attrs, ctrl) {
        var body, container;
        body = attrs.modalBody || 'open-modal';
        container = attrs.container || 'section';
        elm.hide();
        scope.$watch('$rsmodal.' + attrs.modalShow, function(show) {
          if (show) {
            angular.element('body').addClass(body);
            angular.element('[modal-show]').hide();
            elm.show();
            elm.find(container).hide().slideDown('slow');
            return;
          }
          return elm.find(container).slideUp('slow', function() {
            elm.hide();
            if (!angular.element('[modal-show]:visible').length) {
              return angular.element('body').removeClass(body);
            }
          });
        });
        elm.click(function() {
          return scope.$apply(function() {
            return ctrl.close();
          });
        });
        return elm.find(container).click(function(e) {
          return e.stopPropagation();
        });
      }
    };
  }).directive('modalClose', function() {
    return {
      require: '^modalShow',
      link: function(scope, elm, attrs, ctrl) {
        return elm.click(function() {
          return scope.$apply(function() {
            return ctrl.close();
          });
        });
      }
    };
  });

}).call(this);
