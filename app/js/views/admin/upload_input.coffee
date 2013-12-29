App.UploadInput = Ember.View.extend
  tagName: 'input'
  attributeBindings: ['type', 'id']
  type: 'file'

  change: (e)->
    reader = new FileReader()
    @resizeAndSetImage(e.target.files[0], reader)


  resizeAndSetImage: (file, reader) ->
    view = @

    reader.onloadend = ->
      tempImg = new Image()
      tempImg.src = reader.result
      tempImg.onload = ->
        MAX_WIDTH = 400
        MAX_HEIGHT = 300
        tempW = tempImg.width
        tempH = tempImg.height
        if tempW > tempH
          if tempW > MAX_WIDTH
            tempH *= MAX_WIDTH / tempW
            tempW = MAX_WIDTH
        else
          if tempH > MAX_HEIGHT
            tempW *= MAX_HEIGHT / tempH
            tempH = MAX_HEIGHT
        canvas = document.createElement("canvas")
        canvas.width = tempW
        canvas.height = tempH
        ctx = canvas.getContext("2d")
        ctx.drawImage this, 0, 0, tempW, tempH
        dataURL = canvas.toDataURL("image/jpeg")
        view.set('content.image', dataURL)
        canvas.destroy()
    reader.readAsDataURL file
