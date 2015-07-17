# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  window.Helpers = 
    applyRaty: (selector)->
      $(selector).raty(
        score: ->
          $(this).attr('data-stars');
        ,
        click: (score, e) ->
          console.log('clicked; action is ', $(this).parents('form').prop('action'))
          $(this).children('input').val(score)
          $(this).parents('form').trigger('submit.rails')
        ,
        scoreName: 'rating[stars]',
        starType: 'i' )
  Helpers.applyRaty('.raty')