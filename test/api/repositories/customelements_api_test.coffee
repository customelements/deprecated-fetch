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

    describe "with Real API URL", ->
      it "returns the full json of repos in github", (done) ->
        api = new CustomElementsAPI(APIendPoint)

        api.request().then (repos) ->
          expect(repos[0].repository).eql "x-tag/appbar"
          expect(repos[1].repository).eql "x-tag/flipbox"

          done()

        .fail (err) -> done(err)
