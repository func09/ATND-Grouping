class Grouping
  @init: ()->
    
    $('#loading')
      .ajaxStart ()->
        $(this).fadeIn()
      .ajaxStop ()->
        $(this).fadeOut()
    
    $('#grouping_groupings_count')
      .live 'change', (event) ->
        if @.selectedIndex == 0
          $('#btn_shuffle').attr('disabled','disabled')
          $('li.shuffle').attr('disabled','disabled')
        else
          $('#btn_shuffle').removeAttr('disabled')
          $('li.shuffle').removeAttr('disabled')
          
    $('#new_grouping')
      .live 'ajax:complete', (event, data, status, xhr)->
        $('#results').html(data.responseText)
    
    $('li.shuffle').live 'click', (e)->
      e.preventDefault()
      unless $(@).attr('disabled')
        $('#new_grouping').submit()
      
    $('li.result').live 'click', (e)->
      e.preventDefault()
      json = $.parseJSON($('#results-json').text())
      callback = (data,status)->
        window.location.href = "/groupings/#{data._id}"
      $.post '/groupings', {grouping: json}, callback, 'json'
    
    $('#grouping_groupings_count').change()

window.Grouping = Grouping
