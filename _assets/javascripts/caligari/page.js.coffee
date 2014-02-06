class Caligari.Page
  constructor: (@pageId)->
    @contentEl = $("#content")
    @navigationEl = $("#navigation")
    @updateNavigation()
    bgs = @contentEl.data('bg-images').split(" ")
    bgOptions =
      duration: @contentEl.data('bg-duration')
      fade: @contentEl.data('bg-fade')
    console.log bgs, bgOptions, @pageId
    unless _.size(bgs) == 1
      $.backstretch @prefix(bgs), bgOptions
    else
      $.backstretch bgs.pop()

  prefix: (fileNames)->
    "/assets/#{fileName}" for fileName in fileNames

  updateNavigation: ->
    $("li", @navigationEl).removeClass('current')
    $("li[data-title='#{@pageId}']", @navigationEl).addClass('current')