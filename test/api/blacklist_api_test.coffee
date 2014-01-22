expect       = require('chai').expect
Q            = require('q')
_            = require('lodash')
fs           = require('fs')
path         = require('path')
BlackListApi = projectRequire("api/blacklist_api")

APIendPoint = "https://raw2.github.com/customelements/customelements.io/gh-pages/data/blacklist.json"

describe.only "Blacklist Api", ->
  describe "#constructor", ->
    it "creates an instance of BlackListApi", ->
      expect(new BlackListApi()).to.be.instanceOf BlackListApi

  describe "Properties", ->
    api = null

    expectProperty = (name, value = "") ->
      it "expect #{name} property", ->
        api = new BlackListApi()

        expect(api[name]).eq value

    expectProperty("apiUrl")

  describe "#request", ->
    it "fail for a invalid url", (done) ->
      api = new BlackListApi("bad-url")

      api.request().fail (err) -> done()

    describe "with Real API URL", ->
      it "returns the full json of repos in github", (done) ->
        api = new BlackListApi(APIendPoint)

        api.request().then (repos) ->
          expect(repos[0].repository).eql "x-tag/core"
          expect(repos[1].repository).eql "Polymer/polymer"

          done()

        .fail (err) -> done(err)

  describe "#repos", ->
    m = {}
    before ->
      m.klass = _.clone(BlackListApi)
      m.klass.prototype.request = ->
        defer = Q.defer()
        fs.readFile path.join(__dirname, "..", "fixtures", "api", "blacklist_api.json"), (err, file) ->
          defer.reject(err) if err
          defer.resolve(JSON.parse(file))

        defer.promise

      m.api = new m.klass("what-ever")

    it "returns empty json for bad request", (done) ->
      m.api.repos().then (repos) ->
        expect(repos[0]).eq "x-tag/core"
        expect(repos[1]).eq "Polymer/polymer"

        done()
      .fail (err) -> done(err)
