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
    @submit()

    dom.$window.on 'load', =>
      @setChangeColor()

    setInterval(@setChangeColor, 50000)

  setChangeColor: ->
    if dom.$window.width() > breakpoint.papa
      setTimeout ->
        dom.$body.removeAttr('class')
        dom.$body.addClass('blue-bottle')
        dom.$container.addClass('white')
        toggleClassShowHide(3, 4, 0)
      , 0

      setTimeout ->
        dom.$body.removeAttr('class')
        dom.$body.addClass('blues')
        dom.$container.addClass('white')
        toggleClassShowHide(4, 0, 1)
      , 10000

      setTimeout ->
        dom.$body.removeAttr('class')
        dom.$body.addClass('parakeet')
        dom.$container.removeClass('white')
        toggleClassShowHide(0, 1, 2)
      , 20000

      setTimeout ->
        dom.$body.removeAttr('class')
        dom.$body.addClass('magic-passport')
        dom.$container.removeClass('white')
        toggleClassShowHide(1, 2, 3)
      , 30000

      setTimeout ->
        dom.$body.removeAttr('class')
        dom.$body.addClass('r')
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

  submit: ->
    $('form').on 'submit', ->
      $('input[type="email"]').val('')

$ ->
  app = new ZEEEN()
