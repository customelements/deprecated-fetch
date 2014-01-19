expect = require('chai').expect
CustomElementsAPI = projectRequire("api/repositories/customelements_api")

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
