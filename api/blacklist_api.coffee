Q           = require('q')
_           = require("lodash")
request     = require('request')
AbstractAPI = require('./abstracts/abstract_api')

class BlackListApi extends AbstractAPI
  constructor: (@apiUrl = "") ->
    @repositories = []

  repos: -> @request().then (repos) ->
    @repositories = repos if repos.length

    _.pluck(@repositories, "repository")

module.exports = BlackListApi
