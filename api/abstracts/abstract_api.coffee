Q       = require('q')
_       = require("lodash")
request = require('request')

responseIsOk = (error, response) -> !error && response && response['statusCode'] != 200

class AbstractAPI
  constructor: (@apiUrl = "") ->

  request: (url = false) ->
    defer = Q.defer()
    options =
      uri: url || @apiUrl
      json: true

    request options, (error, response, body) ->
      defer.reject new Error(error) if error
      defer.reject new Error(error) if responseIsOk(error, response)

      defer.resolve body

    defer.promise

  repos: -> Q([])

module.exports = AbstractAPI
