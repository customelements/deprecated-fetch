expect             = require('chai').expect
Q                  = require('q')
_                  = require('lodash')

AbstractAPI = projectRequire('api/abstracts/abstract_api')

APIendPoint = "https://bower-component-list.herokuapp.com/keyword/web-components"

describe "Abstract API", ->
  describe "#constructor", ->
    it "creates an instance of AbstractAPI", ->
      expect(new AbstractAPI()).to.be.instanceOf AbstractAPI

  describe "Properties", ->
    api = null

    expectProperty = (name, value = "") ->
      it "expect #{name} property", ->
        api = new AbstractAPI()

        expect(api[name]).eq value

    expectProperty("apiUrl")

  describe "#request", ->
    it "fail for a invalid url", (done) ->
      api = new AbstractAPI("bad-url")

      api.request().fail (err) -> done()

    describe "with Real API URL", ->
      it "returns the full json of repos in github", (done) ->
        api = new AbstractAPI(APIendPoint)

        api.request().then (repos) ->
          expect(repos).instanceOf Object

          done()

        .fail (err) -> done(err)

