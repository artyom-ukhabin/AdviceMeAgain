# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
#TODO: also restrict content fields duplication
#TODO: return whole list if no term provided
#TODO: refactor

#TODO: delete search results at the bottom
#TODO: all forms rerenders after create, fix

  #Autocomplete events

  $('#posts_section').on('keydown.autocomplete', '.content_input', (e) ->
    $(this).autocomplete
      source: setAutocompleteSource(this)
      autoFocus: true
  )

  $('.main_form_area').on('change', '.content_type_select_box', ->
    parentSection($(this)).find('.content_input').each ->
      $(this).val('')
      $(this).autocomplete("option", "source", setAutocompleteSource($(this))) if $(this).data('uiAutocomplete')
  )

  #Click events

  $('#posts_section').on('click', '.add_content_field', (e)->
    e.preventDefault()
    change_post_wrapper = $('#change_post_wrapper')
    section = $(this).parents('.section_area')
    new_field = prepareNewContentField(change_post_wrapper)
    appendNewField(this, section, new_field)
    setNewFieldPosition(new_field)
  )

  $('#posts_section').on('click', '.add_content_section', (e)->
    e.preventDefault()
    change_post_wrapper = $('#change_post_wrapper')
    main_area = $(this).parents('.main_form_area')
    current_section = main_area.find('.section_area').last()
    disableSelectBox(current_section)
    new_section = prepareNewSection(change_post_wrapper, main_area)
    appendNewSection(this, main_area, new_section)
    if maxSectionsReached(main_area)
      $(this).hide()
  )

  $('#posts_section').on('click', '.remove_content_field', (e)->
    e.preventDefault()
    current_field = $(this).parents('.content_field')
    updateContentFieldPositions(current_field)
    current_field.remove()
  )

  $('#posts_section').on('click', '.remove_content_section', (e)->
    e.preventDefault()
    $(this).parents('.section_area').remove()
    if $(this).parents('.main_form_area').find('.add_content_section').is(":visible") != true
      $('.add_content_section').show()
  )

  #Submit event

  $('#posts_section').on('click', 'input[type="submit"]', (e) ->
    e.preventDefault()
    main_area = $(this).parents('.main_form_area')
    main_area.find('.content_type_select_box').each -> $(this).attr('disabled',true)
    $(this).parents('form').trigger('submit.rails')
    main_area.find('.content_type_select_box').each -> $(this).removeAttr('disabled')
  )

updateContentFieldPositions = (field) ->
  field.nextAll('.content_field').each ->
    position_input = $(this).find('.content_position')
    position_value = parseInt(position_input.val())
    position_input.val(position_value - 1)

setNewFieldPosition = (new_field) ->
  section = $(new_field).parents('.section_area')
  previous_position = section.find('.content_position').eq(-2)
  new_field.find('.content_position').val(parseInt(previous_position.val()) + 1)

setTypesForNewSection = (new_section, main_area) ->
  default_select_box = $('.default_section_area').find('.content_type_select_box')
  used_types = main_area.find('.section_area').map ->
    return $(this).find('.content_type_select_box').val() #TODO: compact
  $.each(used_types, (index, type) ->
    $(new_section).find("option[value=" + type + ']').remove())

maxSectionsReached = (main_area) ->
  max_allowed_amount = main_area.data('max-sections-amount')
  current_amount = main_area.find('.section_area').length
  current_amount == max_allowed_amount

disableSelectBox = (section) ->
  select_box = section.find('.content_type_select_box')
  select_box.attr('disabled',true)

appendNewField = (anchor_element, section, field) ->
  field_array = section.find('.content_field')
  if field_array.length != 0
    field_array.last().after(field)
  else
    $(anchor_element).before(field)

appendNewSection = (anchor_element, main_area, section) ->
  section_array = $(main_area).find('.section_area')
  if section_array.length != 0
    section_array.last().after(section)
  else
    $(anchor_element).before(section)

setAutocompleteSource = (input) ->
  #TODO: think about it
  '/' + getSectionType(parentSection(input)) + '/' + $(input).data('autocomplete-action-path')

getSectionType = (section) ->
  $(section).find('.content_type_select_box').val()

parentSection = (section_element) ->
  $(section_element).parents('.section_area')

prepareNewContentField = (change_post_wrapper) ->
  field = change_post_wrapper.find('.default_content_field').clone()
  field.removeClass('default_content_field')
  field.addClass('content_field')
  field

prepareNewSection = (change_post_wrapper, main_area) ->
  section = change_post_wrapper.find('.default_section_area').clone()
  section.removeClass('default_section_area')
  section.addClass('section_area')
  setTypesForNewSection(section, main_area)
  section