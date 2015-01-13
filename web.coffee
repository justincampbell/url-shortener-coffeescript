express = require('express')
shortener = require('./shortener')

app = express()
port = process.env.PORT || 3000

app.get '/', (req, res, next) ->
  res.redirect 'https://github.com/justincampbell/url-shorteners'

app.get '/shorten', (req, res, next) ->
  url = req.query.url

  return res.sendStatus(400) unless url

  token = shortener.shorten(url)
  res.status(201).send("/#{token}")

app.get '/:token', (req, res, next) ->
  token = req.params.token
  url = shortener.expand(token)

  return res.sendStatus(404) unless url

  res.redirect url

app.listen port
console.log "Listening on #{port}"

module.exports = app: app
