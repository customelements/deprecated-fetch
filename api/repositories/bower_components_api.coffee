Q = require('q')
request = require('request')

class BowerComponentsAPI
  constructor: (@apiUrl = "") ->

  repos: -> Q {}

  request: ->
    defer = Q.defer()
    options =
      uri: @apiUrl
      json: true

    request options, (error, response, body) ->
      defer.reject new Error(error) if error
      defer.reject new Error(error) if !error && response.statusCode != 200

      defer.resolve body

    defer.promise

module.exports = BowerComponentsAPI
