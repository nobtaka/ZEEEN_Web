'use strict';

gulp = require 'gulp'
$ = require('gulp-load-plugins')()
browserSync = require 'browser-sync'
httpProxy = require 'http-proxy'
runSequence = require 'run-sequence'
del = require 'del'


paths =
  app: 'app'
  dest: 'dist'
  src: 'src'
  lib:
    vendor: 'libs/*.js'
  images:
    src: 'app/images/**/*'
    cwd: 'app/images'
    dest: 'dist/images'
  templates:
    src: 'app/{,**/}*.jade'
    cwd: 'app'
    dest: '.tmp'
  scss:
    src: 'app/styles/{,**/}*.scss'
    cwd: 'app/styles'
    dest: '.tmp/styles'
  scripts:
    src: 'app/scripts/*.coffee'
    cwd: 'app/scripts'
    dest: '.tmp/scripts'
  html:
    src: 'app/**/*.html'
    dest: 'dist'


gulp.task 'styles', ->
  scssFileter = $.filter ['pages/*.scss', 'global/*.scss']

  gulp.src paths.scss.src
    .pipe $.plumber $.util.log
    .pipe scssFileter
    .pipe $.scsslint(
      config: 'scss-lint-config.yml'
    )
    .pipe scssFileter.restore()
    .pipe $.scsslint.reporter()
    .pipe $.sass
      style: 'expanded'
      includePaths: require('node-bourbon').includePaths
    .pipe $.autoprefixer 'last 1 version'
    .pipe gulp.dest paths.scss.dest


gulp.task 'images', ->
  gulp.src paths.images.src
    .pipe $.plumber $.util.log
    .pipe $.cached $.imagemin
      progressive: true
      interlaced: true
    .pipe gulp.dest paths.images.dest
    .pipe $.size()


gulp.task 'clean', ->
  gulp.src ['.tmp', 'dist'],
    read: false
  .pipe $.clean()


gulp.task 'templates', ->
  gulp.src paths.templates.src
    .pipe $.plumber $.util.log
    .pipe $.ignore.exclude '**/_*.jade'
    .pipe $.jade
      basedir: paths.templates.cwd
      pretty: true
    .pipe gulp.dest paths.templates.dest


gulp.task 'scripts', ->
  gulp.src paths.scripts.src
    .pipe $.plumber $.util.log
    .pipe $.coffeelint()
    .pipe $.coffeelint.reporter()
    .pipe $.coffee()
    .pipe gulp.dest paths.scripts.dest


gulp.task 'scripts:lib', ->
  gulp.src paths.lib.vendor
    .pipe $.plumber $.util.log
    .pipe $.concat 'vendor.js'
    .pipe gulp.dest paths.scripts.dest


gulp.task 'files',[
  'templates',
  'scripts',
  'scripts:lib',
  'styles'
], ->
  jsFilter = $.filter '**/*.js'
  cssFilter = $.filter '**/*.css'

  gulp.src '.tmp/{,**/}*.html'
    .pipe $.plumber $.util.log
    .pipe $.useref.assets searchPath: 'app'
    .pipe jsFilter
    .pipe $.uglify()
    .pipe jsFilter.restore()
    .pipe cssFilter
    .pipe $.csso()
    .pipe cssFilter.restore()
    .pipe $.useref.restore()
    .pipe $.useref()
    .pipe gulp.dest 'dist'
    .pipe $.size()


gulp.task 'serve', [
  'templates'
  'scripts'
  'scripts:lib'
  'styles'
],  ->
  browserSync
    server:
      baseDir: ['.tmp', 'app']
    browser: "google chrome"

  gulp.watch paths.scss.src, ['styles']
  gulp.watch paths.images.src
  gulp.watch paths.templates.src, ['templates']
  gulp.watch paths.scripts.src, ['scripts']


gulp.task 'serve:dist', ['build'], ->
  browserSync
    server:
      baseDir: 'dist'
    browser: "google chrome"


gulp.task 'build', ->
  runSequence('clean', ['images', 'files']);
