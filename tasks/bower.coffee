'use strict';

gulp = require 'gulp'
$ = require('gulp-load-plugins')()
mainBowerFiles = require('main-bower-files')

gulp.task 'bower:install', $.shell.task([
  'bower install'
])

gulp.task 'bower', ['bower:install'], ->
  return gulp.src mainBowerFiles()
