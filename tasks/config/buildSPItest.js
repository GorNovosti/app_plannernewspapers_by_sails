/***
 * Build 
 * @author Nikolay Gerzhan <nikolay.gerzhan@gmail.com>
 * @description Task Build SPA  
 */

/**
 * Compile CoffeeScript files to JavaScript.
 *
 * ---------------------------------------------------------------
 *
 * Compiles coffeeScript files from `assest/js` into Javascript and places them into
 * `.tmp/public/js` directory.
 *
 * For usage docs see:
 * 		https://github.com/gruntjs/grunt-contrib-coffee
 */
module.exports = function (grunt) {
    grunt.config.set('dirConfigSPI', {
        // Directory variables for development / production

        dev: 'assets/spi_src',
        build: 'assets/spi'//.tmp/public

    });
    
    grunt.config.set('requirejs', {
        app: {
            options: {
                //appDir: '/src_client',
                mainConfigFile: '<%= dirConfigSPI.dev %>/config-require-build.js',
                baseUrl: "<%= dirConfigSPI.dev %>/app",
                out: "<%= dirConfigSPI.build %>/app/spi.js",
                optimize: 'none', //'uglify2',
                //useStrict: true,
                name: "spi",
                include: [
                    //  '../config-require-build',                   
                    //'spi'
                    'cs!./states'
                ],
                CoffeeScript: {
                    bare: false
                },
                exclude: ['angular', 'coffee-script'],
                stubModules: ['text', 'tpl', 'cs'],
                
                findNestedDependencies: true,
//                dir: 'assets/www-build',
//                
//                modules: [{
//                        name: "./config-require"
//                    }]
            }
        }//,
//        newspapers: {
//            options: {
//                //appDir: '/src_client',
//                mainConfigFile: './assets/src_client/config-require-build.js',
//                baseUrl: "assets/src_client/newspapers",
//                out: "assets/spi/newspapers/spi.js",
//                optimize: 'none', //'uglify2',
//                // name: "spi",
//                include: [
//                    '../config-require-build',
//                    'index'
//                ],
//                CoffeeScript: {
//                    bare: false
//                },
//                exclude: ['angular', 'coffee-script'],
//                stubModules: ['text', 'tpl'],
//                findNestedDependencies: true,
////                dir: 'assets/www-build',
////                
////                modules: [{
////                        name: "./config-require"
////                    }]
//            }
//        }
    });
    grunt.loadNpmTasks("grunt-requirejs");
};

