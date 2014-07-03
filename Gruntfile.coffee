module.exports = (grunt) ->

  grunt.initConfig
    clean:
      all: [".tmp", "dist"]
      tmp: [".tmp"]
      tmpCoffee: [".tmp/**/*.coffee"]
    copy:
      package:
        src: 'package.json'
        dest: 'dist/'
      tmp:
        expand: true
        cwd: "lib/"
        src: "**"
        dest: ".tmp/"
        dot: true
      dist:
        expand: true
        cwd: ".tmp/"
        src: "**"
        dest: "dist/"
        dot: true
    coffee:
      tmp:
        options:
          bare: true
        expand: true
        cwd: ".tmp/"
        src: ["**/*.coffee"]
        dest: ".tmp/"
        ext: ".js"
    uglify:
      tmp:
        options:
          mangle: false
        files: [
          expand: true
          cwd: ".tmp/"
          src: "**/*.js"
          dest: ".tmp/"
        ]

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-uglify'

  grunt.registerTask "dist", ["copy:tmp", "coffee:tmp", "clean:tmpCoffee", "uglify:tmp", "copy:dist", "copy:package", "clean:tmp"]
  grunt.registerTask "default", ["dist"]