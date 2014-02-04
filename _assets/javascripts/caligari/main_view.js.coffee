@Caligari.MainView =
  load: ->
    console.log "booting caligari -- and really wow!"
    page = new Caligari.Page $("#content").attr('class')
    # nav = new Caligari.Navigation
    # nav.select(page)