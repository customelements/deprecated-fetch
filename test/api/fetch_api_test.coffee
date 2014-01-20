expect   = require('chai').expect
Q        = require('q')
_        = require('lodash')
FetchAPI = projectRequire("api/fetch_api")

describe "Fetch API", ->
  describe "#constructor", ->
    it "creates an instance of FetchAPI", ->
      expect(new FetchAPI()).to.be.instanceOf FetchAPI

  describe "APIs params", ->
    it "receives api sources", ->
      api = new FetchAPI("", "")

      expect(api.sources.length).eq 2

  describe "#repos", ->
    failMe = ->
      d = Q.defer()
      d.reject(new Error("good"))
      d.promise

    it "fails when one or more sources fails", (done) ->
      api = new FetchAPI(failMe(), Q(true))

      api.repos().fail -> done()

    it "succeds when all promises are ok", (done) ->
      api = new FetchAPI(true, true)

      api.repos().then (repos) ->
        done()

      .fail (err) -> done(err)

    it "returns all jsons from apis mergeds", (done) ->
      json1 = ['repo1', 'repo2']
      json2 = ['repo3', 'repo4']

      api = new FetchAPI(Q(json1), Q(json2))

      api.repos().then (repos) ->
        expect(repos).eql _.flatten([json1, json2])

        done()

      .fail (err) -> done(err)

    it "returns all jsons without duplicated repositories", (done) ->
      json1 = ['repo1', 'repo2']
      json2 = ['repo1', 'repo4']

      api = new FetchAPI(Q(json1), Q(json2))

      api.repos().then (repos) ->
        expect(repos).eql ['repo1', 'repo2', 'repo4']

        done()

      .fail (err) -> done(err)

    describe "Excluding", ->
      it "returns all jsons filtered by exclude option", (done) ->
        json1        = ['repo1', 'repo2']
        json2        = ['repo3', 'repo4']
        excludeRepos = ['repo2', 'repo4']

        api = new FetchAPI(Q(json1), Q(json2))

        api.repos(exclude: excludeRepos).then (repos) ->
          expect(repos).eql ['repo1', 'repo3']

          done()

        .fail (err) -> done(err)
