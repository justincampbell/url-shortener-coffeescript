assert = require('assert')
shortener = require('../shortener')

url = "http://justincampbell.me"

describe 'Shortener', ->
  it 'shortens and expands a url', ->
    token = shortener.shorten(url)
    assert shortener.expand(token) == url

  it 'generates unique tokens', ->
    assert shortener.shorten(url) != shortener.shorten(url)

  it 'generates tokens as strings', ->
    token = shortener.shorten(url)
    assert typeof(token) is 'string'
