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
          $('#btn_shuffle').css('display','none')
        else
          $('#btn_shuffle').removeAttr('disabled')
          $('li.shuffle').removeAttr('disabled')
          $('#btn_shuffle').css('display','block')
          
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

$(document).ready ->
  $("#grouping_event_url").blur(->
    $$ = $(this)
    $$.css({"color": "#888","font-size": "14px","text-weight": "normal"}).val $$.attr("title")  if $$.val() is "" or $$.val() is $$.attr("title")
  ).focus(->
    $$ = $(this)
    $$.css("color", "#000").val ""  if $$.val() is $$.attr("title")
  ).parents("form:first").submit(->
    $$ = $("#grouping_event_url")
    $$.triggerHandler "focus"  if $$.val() is $$.attr("title")
  ).end().blur()