'use strict';

gulp = require 'gulp'
$ = require('gulp-load-plugins')()
browserSync = require 'browser-sync'
modRewrite = require 'connect-modrewrite'

meta = require '../package.json'
path = meta.gulpvars

gulp.task 'serve', [
  'bower'
  'templates'
  'scripts'
  'styles'
  'fonts'
  'php'
],  (baseDir, files, browser)->
  browserSync
    server:
      baseDir: ['.tmp', 'app']
    notify: false
    browser: 'google chrome'

  tmp = {}
  for key of path
    tmp = path[key].slice(2)
    path[key] = tmp

  gulp.watch ["#{path['src']}/**/*.jade"], ['templates']
  gulp.watch ["#{path['stylesSrc']}/**/*.scss"], ['styles']
  gulp.watch ["#{path['scriptsSrc']}/**/*.coffee"], ['scripts']
  gulp.watch ["#{path['iconsSrc']}/*.svg"], ['fonts']

gulp.task 'serve:dist', ['build'], ->
  browserSync
    server:
      baseDir: 'dist'
    browser: "google chrome"
