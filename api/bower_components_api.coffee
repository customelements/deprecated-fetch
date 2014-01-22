Q       = require('q')
_       = require("lodash")
request = require('request')

responseIsOk = (error, response) -> !error && response && response['statusCode'] != 200

class BowerComponentsAPI
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

  repos: -> @request().then (repos) ->

    _.map repos, (result) -> result.website.replace("https://github.com/", "")

module.exports = BowerComponentsAPI
