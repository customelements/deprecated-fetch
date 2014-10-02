Q           = require('q')
_           = require("lodash")
request     = require('request')
AbstractAPI = require('./abstracts/abstract_api')

class NPMModulesAPI extends AbstractAPI
  modules: -> @request().then (modules) ->
    if modules
      _.map modules.rows, (result) ->
        key = result.key

        {
          name: key[1],
          description: key[2]
        }
    else
      false

module.exports = NPMModulesAPI
