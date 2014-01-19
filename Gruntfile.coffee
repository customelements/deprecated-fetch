module.exports = (grunt) ->
  grunt.loadNpmTasks("grunt-contrib-watch")
  grunt.loadNpmTasks("grunt-mocha-cli")

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    mochacli:
      options:
        reporter: "spec"
        bail: true

      all: ["test/_helper.js", "test/**/*_test.coffee"]

    watch:
      test:
        options:
          nospawn: true

        files: ["Gruntfile.coffee", "test/**/*.coffee"]
        tasks: ["mochacli"]

  grunt.registerTask 'default', ['watch']
