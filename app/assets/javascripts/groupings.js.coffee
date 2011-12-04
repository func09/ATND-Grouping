class Grouping
  @init: ()->
    $('#new_grouping')
      .live 'ajax:complete', (event, data, status, xhr)->
        # console.log(data)
        $('#results').html(data.responseText)

window.Grouping = Grouping
