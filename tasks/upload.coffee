'use strict';

gulp = require 'gulp'
$ = require('gulp-load-plugins')()

meta = require '../package.json'
path = meta.gulpvars

gulp.task 'upload', ['build'], ->
  gulp.src ["#{path['dist']}/**"]
    .pipe $.ftp
      host: 'users041.lolipop.jp'
      user: 'lolipop.jp-hanagejet'
      pass: '1c6ew7f1'
      remotePath: '/demo/zeeen/'
