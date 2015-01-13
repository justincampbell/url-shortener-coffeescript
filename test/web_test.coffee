assert = require('assert')
request = require('supertest')

app = require('../web').app
url = 'http://justincampbell.me'

describe 'GET /', ->
  it 'redirects to the home page', (done) ->
    request(app)
      .get('/')
      .expect('Location', 'https://github.com/justincampbell/url-shorteners')
      .expect(302, done)

describe 'GET /shorten', ->
  it 'returns a token path when given a url', (done) ->
    request(app)
      .get('/shorten?url=' + url)
      .expect(/\/\d+/)
      .expect(201, done)

  it 'returns bad request when the url is missing', (done) ->
    request(app)
      .get('/shorten')
      .expect(400, done)

  it 'returns bad request when the url is blank', (done) ->
    request(app)
      .get('/shorten?url=')
      .expect(400, done)

describe 'GET /:token', ->
  it 'redirects to the url for a valid token', (done) ->
    request(app)
      .get("/shorten?url=#{url}")
      .end (err, res) ->
        token = res.text

        request(app)
          .get(token)
          .expect('Location', url)
          .expect(302, done)

  it 'returns missing when given a nonexistent token', (done) ->
    request(app)
      .get('/12345')
      .expect(404, done)
