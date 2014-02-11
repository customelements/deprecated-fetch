expect            = require('chai').expect
Q                 = require('q')
_                 = require('lodash')
fs                = require('fs')
path              = require('path')
CustomElementsAPI = projectRequire("api/customelements_api")

APIendPoint = "https://raw2.github.com/webcomponents/customelements.io/gh-pages/data/repos.json"

describe "CustomElements API", ->
  describe "#constructor", ->
    it "creates an instance of CustomElementsAPI", ->
      expect(new CustomElementsAPI()).to.be.instanceOf CustomElementsAPI

  describe "Properties", ->
    api = null

    expectProperty = (name, value = "") ->
      it "expect #{name} property", ->
        api = new CustomElementsAPI()

        expect(api[name]).eq value

    expectProperty("apiUrl")

  describe "#request", ->
    it "fail for a invalid url", (done) ->
      api = new CustomElementsAPI("bad-url")

      api.request().fail (err) -> done()

    describe "with Real API URL", ->
      it "returns the full json of repos in github", (done) ->
        api = new CustomElementsAPI(APIendPoint)

        api.request().then (repos) ->
          expect(repos[0].repository).eql "x-tag/appbar"
          expect(repos[1].repository).eql "x-tag/flipbox"

          done()

        .fail (err) -> done(err)

  describe "#repos", ->
    m = {}
    before ->
      m.klass = _.clone(CustomElementsAPI)
      m.klass.prototype.request = ->
        defer = Q.defer()
        fs.readFile path.join(__dirname, "..", "fixtures", "api", "customelements_api.json"), (err, file) ->
          defer.reject(err) if err
          defer.resolve(JSON.parse(file))

        defer.promise

      m.api = new m.klass("what-ever")

    it "returns empty json for bad request", (done) ->
      m.api.repos().then (repos) ->
        expect(repos[0]).eq "x-tag/appbar"
        expect(repos[1]).eq "x-tag/flipbox"

        done()
      .fail (err) -> done(err)
