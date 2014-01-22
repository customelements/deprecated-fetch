Q       = require('q')
_       = require("lodash")
request = require('request')

responseIsOk = (error, response) -> !error && response && response['statusCode'] != 200

class AbstractAPI
  constructor: (@apiUrl = "") ->

  request: ->
    defer = Q.defer()
    options =
      uri: @apiUrl
      json: true

    request options, (error, response, body) ->
      defer.reject new Error(error) if error
      defer.reject new Error(error) if responseIsOk(error, response)

      defer.resolve body

    defer.promise


module.exports = AbstractAPI
