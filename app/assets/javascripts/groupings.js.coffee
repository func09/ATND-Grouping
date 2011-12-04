class Grouping
  @init: ()->
    $('#new_grouping')
      .live 'ajax:complete', (event, data, status, xhr)->
        # console.log(data)
        $('#results').html(data.responseText)
    
    $('#save').live 'click', (e)->
      e.preventDefault()
      json = $.parseJSON($('#results-json').text())
      callback = (data,status)->
        window.location.href = "/groupings/#{data._id}"
      $.post '/groupings', {grouping: json}, callback, 'json'
        # console.log(data)
        # json = $.parseJSON(data.responseText)

window.Grouping = Grouping
