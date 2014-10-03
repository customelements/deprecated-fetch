Q            = require('q')
_            = require('lodash')
request      = require('request')
AbstractAPI  = require('./abstracts/abstract_api')
NpmModuleURL = 'https://skimdb.npmjs.com/registry/';

class NPMModulesAPI extends AbstractAPI
  modules: -> @request().then (modules) ->
    if modules
      _.map modules.rows, (result) -> result.key[1]
    else
      false

  repos: ->
    @modules().then (modules) =>
      requests = _.map modules, (module) => @request(NpmModuleURL + module)

      Q.all(requests).then (results) ->
        _.map results, (json) ->
          if json['repository']
            repository = json.repository.url;
            repository = repository.replace('https://github.com/', '')
            repository = repository.replace('http://github.com/', '')
            repository = repository.replace('git://github.com/', '')
            repository = repository.replace('.git', '') if (json.repository.type == 'git')

            repository

module.exports = NPMModulesAPI
