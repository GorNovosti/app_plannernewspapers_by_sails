/**
 * @license RequireJS domReady 2.0.1 Copyright (c) 2010-2012, The Dojo Foundation All Rights Reserved.
 * Available via the MIT or new BSD license.
 * see: http://github.com/requirejs/domReady for details
 */
/*jslint */
/*global require: false, define: false, requirejs: false,
  window: false, clearInterval: false, document: false,
  self: false, setInterval: false */


define('domReady',[],function () {
    

    var isTop, testDiv, scrollIntervalId,
        isBrowser = typeof window !== "undefined" && window.document,
        isPageLoaded = !isBrowser,
        doc = isBrowser ? document : null,
        readyCalls = [];

    function runCallbacks(callbacks) {
        var i;
        for (i = 0; i < callbacks.length; i += 1) {
            callbacks[i](doc);
        }
    }

    function callReady() {
        var callbacks = readyCalls;

        if (isPageLoaded) {
            //Call the DOM ready callbacks
            if (callbacks.length) {
                readyCalls = [];
                runCallbacks(callbacks);
            }
        }
    }

    /**
     * Sets the page as loaded.
     */
    function pageLoaded() {
        if (!isPageLoaded) {
            isPageLoaded = true;
            if (scrollIntervalId) {
                clearInterval(scrollIntervalId);
            }

            callReady();
        }
    }

    if (isBrowser) {
        if (document.addEventListener) {
            //Standards. Hooray! Assumption here that if standards based,
            //it knows about DOMContentLoaded.
            document.addEventListener("DOMContentLoaded", pageLoaded, false);
            window.addEventListener("load", pageLoaded, false);
        } else if (window.attachEvent) {
            window.attachEvent("onload", pageLoaded);

            testDiv = document.createElement('div');
            try {
                isTop = window.frameElement === null;
            } catch (e) {}

            //DOMContentLoaded approximation that uses a doScroll, as found by
            //Diego Perini: http://javascript.nwbox.com/IEContentLoaded/,
            //but modified by other contributors, including jdalton
            if (testDiv.doScroll && isTop && window.external) {
                scrollIntervalId = setInterval(function () {
                    try {
                        testDiv.doScroll();
                        pageLoaded();
                    } catch (e) {}
                }, 30);
            }
        }

        //Check if document already complete, and if so, just trigger page load
        //listeners. Latest webkit browsers also use "interactive", and
        //will fire the onDOMContentLoaded before "interactive" but not after
        //entering "interactive" or "complete". More details:
        //http://dev.w3.org/html5/spec/the-end.html#the-end
        //http://stackoverflow.com/questions/3665561/document-readystate-of-interactive-vs-ondomcontentloaded
        //Hmm, this is more complicated on further use, see "firing too early"
        //bug: https://github.com/requirejs/domReady/issues/1
        //so removing the || document.readyState === "interactive" test.
        //There is still a window.onload binding that should get fired if
        //DOMContentLoaded is missed.
        if (document.readyState === "complete") {
            pageLoaded();
        }
    }

    /** START OF PUBLIC API **/

    /**
     * Registers a callback for DOM ready. If DOM is already ready, the
     * callback is called immediately.
     * @param {Function} callback
     */
    function domReady(callback) {
        if (isPageLoaded) {
            callback(doc);
        } else {
            readyCalls.push(callback);
        }
        return domReady;
    }

    domReady.version = '2.0.1';

    /**
     * Loader Plugin API method
     */
    domReady.load = function (name, req, onLoad, config) {
        if (config.isBuild) {
            onLoad(null);
        } else {
            domReady(onLoad);
        }
    };

    /** END OF PUBLIC API **/

    return domReady;
});


define('cs',{load: function(id){throw new Error("Dynamic load not allowed: " + id);}});

// Generated by CoffeeScript 1.7.1

/*
Namespace module
 */
define('cs!namespace',[], function() {
  var _default_namespace;
  _default_namespace = 'develop';
  return _default_namespace;
});


// Generated by CoffeeScript 1.7.1

/*
Module dependencies
 */
define('cs!module',['angular', 'cs!./namespace', 'cs!./states', 'cs!./draggable/index', 'angular-ui-router', 'angular-ui-router.stateHalper'], function(angular, namespace, states, draggableModuleName) {
  var module;
  console.log(draggableModuleName);
  module = angular.module(namespace, ['ui.router', 'ui.router.stateHelper', draggableModuleName]);
  module.config([
    'stateHelperProvider', function(stateHelperProvider) {
      return stateHelperProvider.setNestedState(states);
    }
  ]);
  module.run([
    function() {
      console.log('run for module', namespace);
      return states.resolve = [];
    }
  ]);
  return module;
});

define('text',{load: function(id){throw new Error("Dynamic load not allowed: " + id);}});

define('text!templates/about.tpl.html',[],function () { return '<!-- template "about.tpl.html"-->\r\n<section>   \r\n    <h1 class="text text-center">About: </h1>\r\n \r\n    <hr>  \r\n</section>\r\n<!-- //template "about.tpl.html"-->';});


// Generated by CoffeeScript 1.7.1

/*
Cache content of template(s) with current name space
 */
define('cs!templates/templatesCache',['cs!./../module', 'cs!./../namespace', 'text!./about.tpl.html'], function(module, namespace, tplIndex) {
  console.log(module);
  return module.run([
    '$templateCache', function($templateCache) {
      $templateCache.put("templates/" + (namespace.replace(/\.+/g, "/")) + "/about.tpl.html", tplIndex);
      return console.log('===', $templateCache.get());
    }
  ]);
});


// Generated by CoffeeScript 1.7.1

/*
    Entry point in module
 */
define('cs!index',['cs!./namespace', 'cs!./module', 'cs!./templates/templatesCache'], function(namespace) {
  return namespace;
});

/***
 *  
 */
define('spi',['domReady!', 'angular', 'cs!./namespace', /*'sails.io',*/'cs!./index'], function (document, angular, namespace, /* io,*/ spi) {

    var app = angular.module('spi' + namespace, [spi]);
    app.config(['$locationProvider', function ($locationProvider) {
            $locationProvider.html5Mode(true);
        }
    ]);
    app.run([function(){
            console.warn('run');
    }]);
    console.log(app['name'], '--develop-', spi);
    try {
        return angular.bootstrap(
                document, [app['name'], function () {
//            var socket = io.connect('http://127.0.0.1:1337/');
//            socket.on('connect', function socketConnected(l) {
//                console.log('Socket is now connected',l);
//            });  
                        //   angular.element(document).find('html').addClass('ng-app');
                    }]);
    } catch (e) {
        console.error(e.stack || e.message || e);
    }
});

// Generated by CoffeeScript 1.7.1

/*
Namespace module
 */
define('cs!draggable/namespace',['cs!./../namespace'], function(parent_namespace) {
  var _default_namespace;
  _default_namespace = 'draggable';
  return parent_namespace + '.' + _default_namespace;
});


// Generated by CoffeeScript 1.7.1

/*
https://github.com/angular-ui/ui-router/wiki/Nested-States-%26-Nested-Views
 */
define('cs!draggable/state',['cs!./namespace'], function(namespace, LOG) {
  var _default_name;
  _default_name = 'draggable';
  console.debug(LOG, "templates/" + (namespace.replace(/\.+/g, "/")) + "/" + _default_name + ".tpl.html");
  return {
    name: _default_name,
    url: "/draggable",
    templateUrl: "templates/" + (namespace.replace(/\.+/g, "/")) + "/draggable.tpl.html",
    controller: [
      '$scope', function($scope) {
        $scope.onDragStart = function(_event) {
          return console.log(_event);
        };
        return $scope.blockTemplates = [
          {
            id: 1,
            name: "Статья "
          }, {
            id: 2,
            name: "Реклама"
          }, {
            id: 3,
            name: "Врезка"
          }
        ];
      }
    ]
  };
});


// Generated by CoffeeScript 1.7.1

/*
https://github.com/angular-ui/ui-router/wiki/Nested-States-%26-Nested-Views
 */
define('cs!states',['cs!./draggable/state'], function(children_state) {
  return {
    name: 'root',
    url: '/test',
    template: '<section ui-view><a href="/test/draggable">test/draggable</a></section>',
    children: [children_state]
  };
});


// Generated by CoffeeScript 1.7.1

/*
Module dependencies
 */
define('cs!draggable/module',['angular', 'cs!./namespace'], function(angular, namespace) {
  return angular.module(namespace, []).directive('draggable', [
    function() {
      return {
        restrict: 'A',
        link: function(scope, element) {
          var el;
          el = element[0];
          el.draggable = true;
          el.addEventListener('dragstart', function(e) {
            this.style.opacity = '0.4';
            e.dataTransfer.effectAllowed = 'move';
            return console.log(e.dataTransfer.effectAllowed = 'move', false);
          });
          return;
          el.addEventListener('dragend', function(e) {
            this.style.opacity = '1';
            e.dataTransfer.effectAllowed = 'move';
            return console.log(e.dataTransfer.effectAllowed = 'move', false);
          });
        }
      };
    }
  ]);
});


// Generated by CoffeeScript 1.7.1

/*
Module configuration
 */
define('cs!draggable/config',['cs!./namespace', 'cs!./module'], function(namespace, module, statespace) {
  return module.config([
    '$stateProvider', function($stateProvider) {

      /*
      Main configuration $stateProvider
       *
       */
    }
  ]);
});


define('text!draggable/templates/draggable.tpl.html',[],function () { return '<!-- template "draggable.tpl.html"-->\r\n<style>\r\n    /* Prevent the text contents of draggable elements from being selectable. */\r\n    [draggable] {\r\n        -moz-user-select: none;\r\n        -khtml-user-select: none;\r\n        -webkit-user-select: none;\r\n        user-select: none;\r\n        Required to make elements draggable in old WebKit\r\n        -khtml-user-drag: element;\r\n        -webkit-user-drag: element;\r\n    }\r\n    .column {\r\n        height: 150px;\r\n        width: 150px;\r\n        float: left;\r\n        border: 2px solid #666666;\r\n        background-color: #ccc;\r\n        margin-right: 5px;\r\n        -webkit-border-radius: 10px;\r\n        -ms-border-radius: 10px;\r\n        -moz-border-radius: 10px;\r\n        border-radius: 10px;\r\n        -webkit-box-shadow: inset 0 0 3px #000;\r\n        -ms-box-shadow: inset 0 0 3px #000;\r\n        box-shadow: inset 0 0 3px #000;\r\n        text-align: center;\r\n        cursor: move;\r\n    }\r\n    .column header {\r\n        color: #fff;\r\n        text-shadow: #000 0 1px;\r\n        box-shadow: 5px;\r\n        padding: 5px;\r\n        background: -moz-linear-gradient(left center, rgb(0,0,0), rgb(79,79,79), rgb(21,21,21));\r\n        background: -webkit-gradient(linear, left top, right top,\r\n            color-stop(0, rgb(0,0,0)),\r\n            color-stop(0.50, rgb(79,79,79)),\r\n            color-stop(1, rgb(21,21,21)));\r\n        background: -webkit-linear-gradient(left center, rgb(0,0,0), rgb(79,79,79), rgb(21,21,21));\r\n        background: -ms-linear-gradient(left center, rgb(0,0,0), rgb(79,79,79), rgb(21,21,21));\r\n        border-bottom: 1px solid #ddd;\r\n        -webkit-border-top-left-radius: 10px;\r\n        -moz-border-radius-topleft: 10px;\r\n        -ms-border-radius-topleft: 10px;\r\n        border-top-left-radius: 10px;\r\n        -webkit-border-top-right-radius: 10px;\r\n        -ms-border-top-right-radius: 10px;\r\n        -moz-border-radius-topright: 10px;\r\n        border-top-right-radius: 10px;\r\n    }\r\n</style>\r\n<style>\r\n    .column.over {\r\n        border: 2px dashed #000;\r\n    }\r\n</style>\r\n<section>\r\n    <h1 class="text text-center">Dragg</h1>\r\n    <hr>\r\n    <div id="columns">\r\n        <div ng-repeat="item in blockTemplates" class="column" draggable="true"><header>{{item.name}}</header></div>\r\n        <!--        <div class="column" draggable="true"><header>Статья</header></div>\r\n                <div class="column" draggable="true"><header>Реклама</header></div>\r\n                <div class="column" draggable="true"><header>Врезка</header></div>-->\r\n    </div>\r\n\r\n</section>\r\n<!-- //template "draggable.tpl.html"-->';});


// Generated by CoffeeScript 1.7.1

/*
Cache content of template(s) with current name space
 */
define('cs!draggable/templates/templatesCache',['cs!./../module', 'cs!./../namespace', 'text!./draggable.tpl.html'], function(module, namespace, tplIndex) {
  console.debug(tplIndex, module);
  return module.run([
    '$templateCache', function($templateCache) {
      $templateCache.put("templates/" + (namespace.replace(/\.+/g, "/")) + "/draggable.tpl.html", tplIndex);
    }
  ]);
});


// Generated by CoffeeScript 1.7.1

/*
Entry point in module
 */
define('cs!draggable/index',['cs!./namespace', 'cs!./module', 'cs!./config', 'cs!./templates/templatesCache'], function(namespace) {
  return namespace;
});

