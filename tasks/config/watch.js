/**
 * Run predefined tasks whenever watched file patterns are added, changed or deleted.
 *
 * ---------------------------------------------------------------
 *
 * Watch for changes on
 * - files in the `assets` folder
 * - the `tasks/pipeline.js` file
 * and re-run the appropriate tasks.
 *
 * For usage docs see:
 * 		https://github.com/gruntjs/grunt-contrib-watch
 *
 */
module.exports = function (grunt) {

    grunt.config.set('watch', {
        api: {
            // API files to watch:
            files: ['api/**/*']
        },
        assets: {
            // Assets to watch:
            files: ['assets/**!(spi_src)/*', 'tasks/pipeline.js'],
            // When assets are changed:
            tasks: ['syncAssets', 'linkAssets']
        },
        spi_app: {
            // Assets to watch:
            files: ['assets/spi_src/app/**/*'],
            // When assets are changed:
            tasks: ['clean:spi_dev', 'requirejs:app', 'copy:spi_dev']
        },
        spi_develop: {
            // Assets to watch:
            files: ['assets/spi_src/develop/**/*'],
            // When assets are changed:
            tasks: ['clean:spi_dev', 'requirejs:develop', 'copy:spi_dev']
        }
    });
    grunt.loadNpmTasks('grunt-contrib-watch');
};
