'use strict';

gulp = require 'gulp'
del = require 'del'
$ = require('gulp-load-plugins')()
runSequence = require 'run-sequence'
meta = require '../package.json'
path = meta.gulpvars

gulp.task 'clean', (cb) ->
  del(['.tmp', 'dist'], cb)

gulp.task 'default', ['clean'], (cb) ->
  runSequence('php', 'fonts', 'scripts', 'styles', ['templates'], cb);

gulp.task 'build', ['default'], ->
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

  gulp.src '.tmp/fonts/*'
    .pipe gulp.dest 'dist/fonts'

  gulp.src 'app/videos/*'
    .pipe gulp.dest 'dist/videos'

  gulp.src 'app/*.png'
    .pipe gulp.dest 'dist'

  gulp.src 'app/*.svg'
    .pipe gulp.dest 'dist'

  gulp.src '.tmp/php/*'
    .pipe gulp.dest 'dist/php'

  gulp.src 'app/images/**'
    .pipe gulp.dest 'dist/images'

gulp.task 'build:upload', ['build'], ->
  gulp.src ["#{path['dist']}/**"]
    .pipe $.ftp
      host: 'users041.lolipop.jp'
      user: 'lolipop.jp-hanagejet'
      pass: '1c6ew7f1'
      remotePath: '/demo/zeeen/'
