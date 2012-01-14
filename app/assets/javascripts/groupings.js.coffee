class Grouping
  
  # シャッフルできる状態か？
  @isShuffle:()->
    $$event_url = $('#grouping_event_url')
    $$groupings_count = $('#grouping_groupings_count')[0]
    return $$groupings_count.selectedIndex != 0 and 
           $$event_url.val() != $$event_url.attr('title') and
           $$event_url.val() != ''
  
  # シャッフルボタンの状態を変更する
  @updateShuffleBtn: ()->
  
    if Grouping.isShuffle()
      # シャッフルボタンを無効にする
      $('#btn_shuffle').attr('disabled','disabled')
      $('li.shuffle').attr('disabled','disabled')
      $('#btn_shuffle').css('display','none')
    else
      # シャッフルボタンを有効にする
      $('#btn_shuffle').removeAttr('disabled')
      $('li.shuffle').removeAttr('disabled')
      $('#btn_shuffle').css('display','block')
  
  @init: ()->
    
    $('#loading')
      .ajaxStart ()->
        $(this).fadeIn()
      .ajaxStop ()->
        $(this).fadeOut()
    
    # イベントURL
    $('#grouping_event_url').change(->
      Grouping.updateShuffleBtn()
    )
    
    # グループ数
    $('#grouping_groupings_count').change(->
      Grouping.updateShuffleBtn()
    )
          
    $('#new_grouping')
      .live 'ajax:complete', (event, data, status, xhr)->
        $('#results').html(data.responseText)
    
    # シャッフルボタン
    $('li.shuffle').live('click', (e)->
      e.preventDefault()
      $('#new_grouping').submit() if Grouping.isShuffle()
    )
      
    $('li.result').live 'click', (e)->
      e.preventDefault()
      json = $.parseJSON($('#results-json').text())
      callback = (data,status)->
        window.location.href = "/groupings/#{data._id}"
      $.post '/groupings', {grouping: json}, callback, 'json'
    
    # 初期処理
    Grouping.updateShuffleBtn()
    # シャッフル可能ならすぐシャッフルする
    $('#new_grouping').submit() if Grouping.isShuffle()
      

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