class ZEEEN
  # _breakpoint.scss
  breakpoint = {
    papa: 767
  }

  dom = {
    $window: $(window)
    $body: $('body')
    $container: $('.container')
  }

  constructor: ->
    @background()

  background: ->
    if dom.$window.width() > breakpoint.papa
      dom.$window.on 'load', ->
        changeColor = ->
          setTimeout ->
            dom.$body.css('background': '#061b33')
            dom.$container.addClass('white')
          , 0

          setTimeout ->
            dom.$body.css('background': '#6cd957')
            dom.$container.removeClass('white')
          , 10000

          setTimeout ->
            dom.$body.css('background': '#fafbfc')
            dom.$container.removeClass('white')
          , 20000

        changeColor()

        setInterval ->
          changeColor()
        , 30000

$ ->
  app = new ZEEEN()
