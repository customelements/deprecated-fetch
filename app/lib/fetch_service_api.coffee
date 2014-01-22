_                 = require('lodash')
FetchAPI          = require('../../api/fetch_api')
BowerAPI          = require('../../api/bower_components_api')
CustomElementsAPI = require('../../api/customelements_api')
BlacklistAPI      = require('../../api/blacklist_api')
ENV               = require("../config/env_vars")

bowerApi          = new BowerAPI(ENV['BOWER_API_URL'])
customElementsApi = new CustomElementsAPI(ENV['CUSTOMELEMENTS_API_URL'])

class FetchServiceAPI
  constructor: ->
    @blackListApi = new BlacklistAPI(ENV['BLACKLIST_API_URL'])

  repos: ->
    @blackListApi.repos().then (blacklist) =>
      new FetchAPI(bowerApi.repos(), customElementsApi.repos()).repos(exclude: blacklist)

module.exports = FetchServiceAPI
