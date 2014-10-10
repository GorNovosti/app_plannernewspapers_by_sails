module.exports = function (grunt) {
	grunt.registerTask('build', [
                'buildSPIs',
		'compileAssets',
		'linkAssetsBuild',
		'clean:build',
		'copy:build'
	]);
};
