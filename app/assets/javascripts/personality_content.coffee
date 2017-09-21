# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#TODO: classes
window.applySelect2ForContent = (content_input) ->
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
  personality_id = $(form).find("#personality_id").val()
  select2DataFunction(personality_id)

select2DataFunction = (personality_id) ->
  (params) ->
    return {
      term: params.term
      personality_id: personality_id
    }

transformResponseForSelect2 = (data) ->
  return { results: buildGroupedData(data) }

buildGroupedData = (data) ->
  results_array = []
  $.each(data, (content_type, collection) ->
    single_type_hash = {}
    single_type_hash['text'] = content_type
    single_type_hash['children'] = renameNameKeysToText(collection)
    results_array.push(single_type_hash)
  )
  results_array

renameNameKeysToText = (objects_array) ->
#TODO: maybe delete is not so important
  $.each(objects_array, (index, item) ->
    item['text'] = item['name']
    delete item['name']
  )