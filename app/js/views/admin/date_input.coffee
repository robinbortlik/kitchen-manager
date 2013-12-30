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
      @set('value', if moment.isMoment(date) then date.utc().format(@get('dateFormat')) else moment.utc(date))
  ).observes('date')

  focusIn: ->
    @set('hasFocus', true)

  focusOut: ->
    @set('hasFocus', false)
    @updateValue()