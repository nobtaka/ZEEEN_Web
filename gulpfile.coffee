'use strict';

gulp = require 'gulp'
$ = require('gulp-load-plugins')()
require('require-dir')('./tasks')

meta = require './package.json'
path = meta.gulpvars

gulp.task 'styles', ->
  scssFileter = $.filter ['pages/*.scss', 'global/*.scss']

  gulp.src ["#{path['stylesSrc']}/{,**/}*.scss"]
    .pipe $.plumber $.util.log
    .pipe scssFileter
    .pipe $.scssLint(
      config: 'scss-lint-config.yml'
    )
    .pipe scssFileter.restore()
    .pipe $.sass
        style: 'expanded'
        includePaths: require('node-bourbon').includePaths
    .on 'error', $.sass.logError
    .pipe $.autoprefixer(
      ['last 1 version', 'ie 9']
    )
    .pipe gulp.dest "#{path['stylesDist']}"


gulp.task 'images', ->
  gulp.src ["#{path['imagesSrc']}/**/*"]
    .pipe $.plumber $.util.log
    .pipe $.imagemin
      progressive: true
      interlaced: true
    .pipe gulp.dest "#{path['imagesDist']}"
    .pipe $.size()


gulp.task 'php', ->
  gulp. src './app/php/*'
    .pipe gulp.dest "./.tmp/php"


gulp.task 'templates', ->
  gulp.src ["#{path['src']}/views/{,**/}*.jade"]
    .pipe $.plumber $.util.log
    .pipe $.ignore.exclude '**/_*.jade'
    .pipe $.jade
      basedir: "#{path['src']}"
      pretty: true
    .pipe gulp.dest "#{path['tmp']}"


gulp.task 'scripts', ->
  gulp.src ["#{path['scriptsSrc']}/{,**/}*.coffee"]
    .pipe $.plumber $.util.log
    .pipe $.coffeelint({"max_line_length": {"level": "ignore"}})
    .pipe $.coffeelint.reporter()
    .pipe $.coffee()
    .pipe gulp.dest "#{path['scriptsDist']}"

gulp.task 'icon-clean', ->
  gulp.src ["#{path['iconsDist']}/*.svg"]
    .pipe $.plumber $.util.log
    .pipe $.clean()

gulp.task 'svg-min', ['icon-clean'], ->
  gulp.src ["#{path['iconsSrc']}/*.svg"]
    .pipe $.plumber $.util.log
    .pipe $.svgmin()
    .pipe gulp.dest "#{path['iconsDist']}/"

gulp.task 'fonts-create', ['svg-min'], ->
  gulp.src ["#{path['fontsDist']}/icon-*"]
    .pipe $.clean()

  gulp.src ["#{path['iconsDist']}/*.svg"]
    .pipe $.plumber $.util.log
    .pipe $.iconfontCss
      fontName: 'icon-font'
      path: "#{path['stylesSrc']}/templates/_icons.scss" # template _icon.scss
      targetPath: "../styles/components/_icons.scss" # create _icon.scss file
      fontPath: "../fonts/" # font src for _icon.scss
    .pipe $.iconfont
      fontName: 'icon-font'
      appendCodepoints: false
    .pipe gulp.dest "#{path['fontsDist']}"

gulp.task 'fonts', ['fonts-create'], ->
  gulp.src ["#{path['fontsDist']}/*"]
    .pipe $.plumber $.util.log
    .pipe gulp.dest "#{path['tmp']}/fonts"
