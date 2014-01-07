App.DateInput = Em.TextField.extend
  type: 'date'
  hasFocus: false
  placeholderBinding: 'dateFormat'
  dateFormat:(-> 'YYYY-MM-DD' ).property()

  init: ->
    @_super()
    @updateValue()

  updateDate: (->
    ms = moment.utc(@get('value'), @get('dateFormat'))
    @set('date', ms) if ms and ms.isValid()
  ).observes('value')

  updateValue: (->
    return if @get('hasFocus')
    date = @get('date')
    if date
      @set('value', date.format(@get('dateFormat')))
  ).observes('date')

  focusIn: ->
    @set('hasFocus', true)

  focusOut: ->
    @set('hasFocus', false)
    @updateValue()