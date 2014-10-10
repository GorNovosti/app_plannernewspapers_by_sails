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
                findNestedDependencies: true
            }
        },
        develop: {
            options: {
                //appDir: '/src_client',
                mainConfigFile: '<%= dirConfigSPI.dev %>/config-require-build.js',
                findNestedDependencies: true,
                baseUrl: "<%= dirConfigSPI.dev %>/develop",
                out: "<%= dirConfigSPI.build %>/develop/spi.js",
                optimize: 'none', //'uglify2',
                //useStrict: true,
                name: "spi",
                include: [ 
                    //'spi'
                    'cs!./states',
                    'cs!./draggable/index'
                ],
                CoffeeScript: {
                    bare: true
                },
                exclude: ['angular', 'coffee-script'],
                stubModules: ['text', 'tpl', 'cs']
            }
        }
    });
    grunt.loadNpmTasks("grunt-requirejs");
};

