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
    @resize()

    dom.$window.on 'load', =>
      @changeColor()

  setChangeColor: ->
    if dom.$window.width() > breakpoint.papa
      console.log 'setChangeColor'
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

  changeColor: ->
    console.log 'changeColor'
    @setChangeColor()

    setInterval =>
      @setChangeColor()
    , 30000

  resize: ->
    timer = false
    dom.$window.on 'resize', =>
      if timer
        clearTimeout(timer)
      timer = setTimeout =>
        if dom.$window.width() < breakpoint.papa
          dom.$body.removeAttr('style')
          dom.$container.removeClass('white')
        else
          @changeColor()
      , 300

$ ->
  app = new ZEEEN()
