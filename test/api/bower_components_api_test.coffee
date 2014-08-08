expect             = require('chai').expect
Q                  = require('q')
_                  = require('lodash')
fs                 = require('fs')
path               = require('path')
BowerComponentsAPI = projectRequire("api/bower_components_api")

APIendPoint = "https://bower-component-list.herokuapp.com/keyword/web-components"

describe "Bower Components API", ->
  describe "#constructor", ->
    it "creates an instance of BowerComponentsAPI", ->
      expect(new BowerComponentsAPI()).to.be.instanceOf BowerComponentsAPI

  describe "#request", ->
    it "fail for a invalid url", (done) ->
      api = new BowerComponentsAPI("bad-url")

      api.request().fail (err) -> done()

    describe "with Real API URL", ->
      it "returns the full json of repos in github", (done) ->
        api = new BowerComponentsAPI(APIendPoint)

        api.request().then (repos) ->
          expect(repos[0].name).to.not.be.empty
          expect(repos[1].name).to.not.be.empty

          done()

        .fail (err) -> done(err)

  describe "#repos", ->
    m = {}
    before ->
      m.klass = _.clone(BowerComponentsAPI)
      m.klass.prototype.request = ->
        defer = Q.defer()
        fs.readFile path.join(__dirname, "..", "fixtures", "api", "bower_components_api.json"), (err, file) ->
          defer.reject(err) if err
          defer.resolve(JSON.parse(file))

        defer.promise

      m.api = new m.klass("what-ever")

    it "returns the json in a common format", (done) ->
      m.api.repos().then (repos) ->
        expect(repos[0]).eq "x-tag/view"
        expect(repos[1]).eq "x-tag/transitions"

        done()
      .fail (err) -> done(err)
