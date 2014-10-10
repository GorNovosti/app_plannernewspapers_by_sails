/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


define(['domReady!', 'angular','cs!./namespace', /*'sails.io',*/'cs!./index'], function (document, angular,namespace,/* io,*/ spi) { 

    var app = angular.module('spi'+namespace, [spi]);
    console.log(app['name'],'------',spi);
    return angular.bootstrap(document.getElementsByTagName('html'), [app['name'], function () {
//            var socket = io.connect('http://127.0.0.1:1337/');
//            socket.on('connect', function socketConnected(l) {
//                console.log('Socket is now connected',l);
//            });

             angular.element(document).find('html').addClass('ng-app');
        }]);
});