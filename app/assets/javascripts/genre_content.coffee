# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.applySelect2ForGenresContent = (content_input) ->
  input = $(content_input)
  initializeSelect2(input)

initializeSelect2 = (input) ->
  input.select2({
    minimumInputLength: 1,
    ajax: {
      url: input.data('url'),
      dataType: 'json',
      data: generateDataFunction(input),
      processResults: transformResponseForSelect2
    }
  })

generateDataFunction = (input) ->
  form = $(input).parents('form')
  genre_id = $(form).find("#genre_id").val()
  select2DataFunction(genre_id)

select2DataFunction = (genre_id) ->
  (params) ->
    return {
      term: params.term
      genre_id: genre_id
    }

transformResponseForSelect2 = (data) ->
  renameNameKeysToText(data)
  return { results: data }

renameNameKeysToText = (objects_array) ->
#TODO: maybe delete is not so important
  $.each(objects_array, (index, item) ->
    item.text = item.name
    delete item.name
  )