App.DatePickerView = Ember.TextField.extend(
  _picker: null

  modelChangedValue: (->
    picker = @get("_picker")
    picker.setDate @get("value")  if picker
  ).observes("value")

  didInsertElement: ->
    currentYear = (new Date()).getFullYear()
    formElement = @$()[0]
    picker = new Pikaday(
      field: formElement
      yearRange: [2014, currentYear + 2]
    )
    @set "_picker", picker

  willDestroyElement: ->
    picker = @get("_picker")
    picker.destroy()  if picker
    @set "_picker", null
)
