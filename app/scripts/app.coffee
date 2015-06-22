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
    @form()
    # @submit()

    dom.$window.on 'load', =>
      @setChangeColor()

    setInterval(@setChangeColor, 98000)

  setChangeColor: ->
    if dom.$window.width() > breakpoint.papa
      setTimeout ->
        dom.$body.removeAttr('class')
        dom.$body.addClass('blue-bottle')
        dom.$container.addClass('white')
        toggleClassShowHide(14, 15, 0)
      , 0

      setTimeout ->
        dom.$body.removeAttr('class')
        dom.$body.addClass('blues')
        dom.$container.addClass('white')
        toggleClassShowHide(15, 0, 1)
      , 6000

      setTimeout ->
        dom.$body.removeAttr('class')
        dom.$body.addClass('parakeet')
        dom.$container.removeClass('white')
        toggleClassShowHide(0, 1, 2)
      , 12000

      setTimeout ->
        dom.$body.removeAttr('class')
        dom.$body.addClass('magic-passport')
        dom.$container.removeClass('white')
        toggleClassShowHide(1, 2, 3)
      , 18000

      setTimeout ->
        dom.$body.removeAttr('class')
        dom.$body.addClass('flatstock')
        dom.$container.addClass('white')
        toggleClassShowHide(2, 3, 4)
      , 24000

      setTimeout ->
        dom.$body.removeAttr('class')
        dom.$body.addClass('hearing')
        dom.$container.addClass('white')
        toggleClassShowHide(3, 4, 5)
      , 30000

      setTimeout ->
        dom.$body.removeAttr('class')
        dom.$body.addClass('hipsters')
        dom.$container.addClass('white')
        toggleClassShowHide(4, 5, 6)
      , 36000

      setTimeout ->
        dom.$body.removeAttr('class')
        dom.$body.addClass('hotter')
        dom.$container.addClass('white')
        toggleClassShowHide(5, 6, 7)
      , 42000

      setTimeout ->
        dom.$body.removeAttr('class')
        dom.$body.addClass('pepsi')
        dom.$container.addClass('white')
        toggleClassShowHide(6, 7, 8)
      , 48000

      setTimeout ->
        dom.$body.removeAttr('class')
        dom.$body.addClass('imate')
        dom.$container.addClass('white')
        toggleClassShowHide(7, 8, 9)
      , 54000

      setTimeout ->
        dom.$body.removeAttr('class')
        dom.$body.addClass('anduin')
        dom.$container.addClass('white')
        toggleClassShowHide(8, 9, 10)
      , 60000

      setTimeout ->
        dom.$body.removeAttr('class')
        dom.$body.addClass('paint')
        dom.$container.addClass('white')
        toggleClassShowHide(9, 10, 11)
      , 66000

      setTimeout ->
        dom.$body.removeAttr('class')
        dom.$body.addClass('spotify')
        dom.$container.addClass('white')
        toggleClassShowHide(10, 11, 12)
      , 72000

      setTimeout ->
        dom.$body.removeAttr('class')
        dom.$body.addClass('tipsy')
        dom.$container.addClass('white')
        toggleClassShowHide(11, 12, 13)
      , 78000

      setTimeout ->
        dom.$body.removeAttr('class')
        dom.$body.addClass('z')
        dom.$container.addClass('white')
        toggleClassShowHide(12, 13, 14)
      , 84000

      setTimeout ->
        dom.$body.removeAttr('class')
        dom.$body.addClass('r')
        dom.$container.addClass('white')
        toggleClassShowHide(13, 14, 15)
      , 90000

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
            setInterval(@setChangeColor(), 98000)
            clearInterval(intervalChangeColor)
          dom.$container.removeClass('white')
        else
          setInterval(@setChangeColor(), 98000)
      , 300

  form: ->
    $('form').find('input')
      .on 'focus', $.proxy (event) ->
        $(event.target).addClass('focus')
      , @

      .on 'blur', $.proxy (event) ->
        if $(event.target).val() == ''
          $(event.target).removeClass('focus')
      , @

  submit: ->
    $('form').on 'submit', ->
      $('input[type="email"]').val('')

$ ->
  app = new ZEEEN()
