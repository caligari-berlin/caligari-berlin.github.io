@Caligari.MainView =
  load: ->
    console.log "booting caligari -- and really wow!"
    page = new Caligari.Page $("#content").data('current')
    # nav = new Caligari.Navigation
    # nav.select(page)