module.exports = function(grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    watch: {
      grunt: { files: ['Gruntfile.js'] },

      livereload: {
        files: ['public/*.html', 'app/assets/javascripts/**/*.{js,json}', 'app/assets/stylesheets/**/*','app/assets/images/**/*.{png,jpg,jpeg,gif,webp,svg}', 'app/views/**/*'],
        options: {
          livereload: true
        }
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-watch');

  grunt.registerTask('default', ['watch']);
}

