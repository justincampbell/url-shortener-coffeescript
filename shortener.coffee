module.exports =
  id: 0
  urls: {}

  shorten: (url) ->
    token = @generateToken()
    @urls[token] = url
    token

  expand: (token) ->
    @urls[token]

  generateToken: ->
    @id += 1
    @id.toString()
