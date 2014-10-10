module.exports = function (grunt) {
	grunt.registerTask('default', ['buildSPIs','compileAssets', 'linkAssets',  'watch']);
};
