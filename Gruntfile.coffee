module.exports = (grunt) ->

  grunt.initConfig
    clean:
      all: [".tmp", "dist"]
      tmp: [".tmp"]
      tmpCoffee: [".tmp/**/*.coffee"]
    copy:
      tmp:
        expand: true
        cwd: "lib/"
        src: "**"
        dest: ".tmp/"
        dot: true
      npm:
        expand: true
        cwd: ".tmp/"
        src: "**"
        dest: "dist/npm/"
        dot: true
      npmPackage:
        src: ['package.json', 'LICENSE.md', 'README.md']
        dest: 'dist/npm/'
      bower:
        src: ".tmp/parse.js"
        dest: "dist/bower/main.js"
      bowerPackage:
        src: ['bower.json', 'LICENSE.md', 'README.md', 'emoji/*']
        dest: 'dist/bower/'
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

  grunt.registerTask "dist", ["copy:tmp", "coffee:tmp", "clean:tmpCoffee", "uglify:tmp",
                              "copy:npm", "copy:npmPackage",
                              "copy:bower", "copy:bowerPackage",
                              "clean:tmp"]
  grunt.registerTask "default", ["dist"]