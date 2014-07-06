module.exports = (grunt) ->

  grunt.initConfig
    clean:
      all: [".tmp", ".tmp_min", "npm_module", "bower_module/emoji", "bower_module/**/*.js"]
      tmp: [".tmp", ".tmp_min"]
      bower: ["bower_module/emoji", "bower_module/**/*.js"]
    copy:
      npm:
        expand: true
        cwd: ".tmp_min/"
        src: "**"
        dest: "npm_module/"
        dot: true
      npmPackage:
        src: ['package.json', 'LICENSE.md', 'README.md']
        dest: 'npm_module/'
      bower:
        src: ".tmp/parse.js"
        dest: "bower_module/main.js"
      bowerMin:
        src: ".tmp_min/parse.js"
        dest: "bower_module/main.min.js"
      bowerPackage:
        src: ['emoji/*']
        dest: 'bower_module/'
    coffee:
      tmp:
        options:
          bare: true
        expand: true
        cwd: "lib/"
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
          dest: ".tmp_min/"
        ]

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-uglify'

  grunt.registerTask "dist", [
    "coffee:tmp", "uglify:tmp", # compile
    "copy:npm", "copy:npmPackage", # copy NPM module
    "clean:bower", "copy:bower", "copy:bowerMin", "copy:bowerPackage", # copy Bower module
    "clean:tmp" # clean
  ]
  grunt.registerTask "default", ["dist"]