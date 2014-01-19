expect            = require('chai').expect
path              = require("path")
fs                = require("fs")
Q                 = require('q')
CustomElementsAPI = projectRequire("api/repositories/customelements_api")

APIendPoint = "https://raw2.github.com/customelements/customelements.io/gh-pages/data/repos.json"

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


    describe "#request with json", ->
      m = {}

      before ->
        CustomElementsAPI.prototype.request = ->
          fixture = path.join(__dirname, "..", "..", "fixtures", "api", "customelements_api.json")

          Q.nfcall(fs.readFile, fixture)

        m.api = new CustomElementsAPI("what-ever")

      it "returns a json with all repositories", (done) ->
        m.api.request().then (repositories) ->
          json = JSON.parse(repositories)

          expect(json[0].repository).eql "x-tag/appbar"
          expect(json[1].repository).eql "x-tag/flipbox"

          done()

        .fail (err) -> done(err)
