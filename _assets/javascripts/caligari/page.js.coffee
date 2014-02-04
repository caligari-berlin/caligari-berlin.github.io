class Caligari.Page
  constructor: (@pageId)->
    @contentEl = $("#content")
    bgs = @contentEl.data('bg-images').split(" ")
    bgOptions =
      duration: @contentEl.data('bg-duration')
      fade: @contentEl.data('bg-fade')
    console.log bgs, bgOptions
    unless _.size(bgs) == 1
      $.backstretch @prefix(bgs), bgOptions
    else
      $.backstretch bgs.pop()

  prefix: (fileNames)->
    "/assets/#{fileName}" for fileName in fileNames