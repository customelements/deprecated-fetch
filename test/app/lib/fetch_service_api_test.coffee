expect          = require('chai').expect
Q               = require('q')
FetchServiceAPI = projectRequire('app/lib/fetch_service_api')

describe "Fetch Service API", ->
  describe "repos", ->
    memo = {}

    before ->
      memo.api = new FetchServiceAPI()
      memo.api.sources = [Q(['repo']), Q(['repo1'])]
      memo.api.blackListApi =
        repos: -> Q([])

    it "succeds when all promises are ok", (done) ->
      memo.api.repos().then (repos) ->
        done()

      .fail (err) -> done(err)
