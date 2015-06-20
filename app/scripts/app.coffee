class ZEEEN
  # _breakpoint.scss
  breakpoint = {
    papa: 767
  }

  dom = {
    $window: $(window)
    $body: $('body')
    $container: $('.container')
    $screen: $('.screens').find('li')
  }

  constructor: ->
    @resize()

    dom.$window.on 'load', =>
      @setChangeColor()

    setInterval(@setChangeColor, 50000)

  setChangeColor: ->
    if dom.$window.width() > breakpoint.papa
      setTimeout ->
        dom.$body.css('background': '#061b33')
        dom.$container.addClass('white')
        toggleClassShowHide(3, 4, 0)
      , 0

      setTimeout ->
        dom.$body.css('background': '#6cd957')
        dom.$container.removeClass('white')
        toggleClassShowHide(4, 0, 1)
      , 10000

      setTimeout ->
        dom.$body.css('background': '#fafbfc')
        dom.$container.removeClass('white')
        toggleClassShowHide(0, 1, 2)
      , 20000

      setTimeout ->
        dom.$body.css('background': '#072847')
        dom.$container.addClass('white')
        toggleClassShowHide(1, 2, 3)
      , 30000

      setTimeout ->
        dom.$body.css('background': '#1ba3db')
        dom.$container.addClass('white')
        toggleClassShowHide(2, 3, 4)
      , 40000

      toggleClassShowHide = (base, hide, show) ->
        dom.$screen.eq(base).removeClass('hide')
        setTimeout ->
          dom.$screen.eq(base).removeAttr('style')
        , 10000 / 2
        dom.$screen.eq(hide).addClass('hide').removeClass('show')
        setTimeout ->
          dom.$screen.eq(hide).css('z-index': -1)
        , 10000 / 2
        dom.$screen.eq(show).addClass('show')

  resize: ->
    timer = false
    dom.$window.on 'resize', =>
      if timer
        clearTimeout(timer)
      timer = setTimeout =>
        if dom.$window.width() < breakpoint.papa
          intervalChangeColor = ->
            setInterval(@setChangeColor(), 50000)
            clearInterval(intervalChangeColor)
          dom.$container.removeClass('white')
        else
          setInterval(@setChangeColor(), 50000)
      , 300

$ ->
  app = new ZEEEN()
