class Grouping
  @init: ()->
    
    $('#loading')
      .ajaxStart ()->
        $(this).fadeIn()
      .ajaxStop ()->
        $(this).fadeOut()
    
    $('#new_grouping')
      .live 'ajax:complete', (event, data, status, xhr)->
        $('#results').html(data.responseText)
    
    $('li.shuffle').live 'click', (e)->
      e.preventDefault()
      $('#new_grouping').submit()
      
    $('li.result').live 'click', (e)->
      e.preventDefault()
      json = $.parseJSON($('#results-json').text())
      callback = (data,status)->
        window.location.href = "/groupings/#{data._id}"
      $.post '/groupings', {grouping: json}, callback, 'json'

window.Grouping = Grouping
