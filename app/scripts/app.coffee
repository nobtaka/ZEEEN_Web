class ZEEEN
  # _breakpoint.scss
  breakpoint = {
    papa: 767
  }

  dom = {
    $window: $(window)
    $body: $('body')
  }

  constructor: ->
    @background()

  background: ->
    dom.$window.on 'load', ->
      dom.$body.css('background': '#061b33')

$ ->
  app = new ZEEEN()
