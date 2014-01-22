Q           = require('q')
_           = require("lodash")
request     = require('request')
AbstractAPI = require('./abstracts/abstract_api')

class CustomElementsAPI extends AbstractAPI
  constructor: (@apiUrl = "") ->

  repos: -> @request().then (repos) -> _.pluck(repos, "repository")

module.exports = CustomElementsAPI
