expect = require('chai').expect
Repository = projectRequire("app/models/repository")

describe "Repository", ->
  describe "#constructor", ->
    it "creates a instance of repository", ->
      expect(new Repository()).to.be.an.instanceOf Repository

  describe "Properties", ->
    repo = null

    expectProperty = (name, value = "") ->
      it "expect #{name} property", ->
        repo = new Repository()

        expect(repo[name]).eq value

    expectProperty("name")
    expectProperty("owner")
    expectProperty("url", "https://github.com//")
    expectProperty("owner_url", "https://github.com/")
    expectProperty("description")
    expectProperty("forks", 0)
    expectProperty("stars", 0)
    expectProperty("created", "")

  describe "#toJSON", ->
    it "expect to return the repository as a json", ->
      repository =
        name: "fetch-service"
        owner: "customelements"
        url: "https://github.com/webcomponents/fetch-service"
        description: "Some description"
        forks: 20
        stars: 10

      repo = new Repository(repository)
      json = repo.toJSON()

      expect(json.name).eq repository.name
      expect(json.owner).eq repository.owner
      expect(json.owner_url).eq repo.ownerUrl()
      expect(json.url).eq repo.repositoryUrl()
      expect(json.description).eq repository.description
      expect(json.forks).eq repository.forks
      expect(json.stars).eq repository.stars

  describe "#repositoryUrl", ->
    repository =
        name: "fetch-service"
        owner: "customelements"
        description: ""
        forks: 0
        stars: 0

    it "returns github repository url", ->
      repo = new Repository(repository)

      expect(repo.repositoryUrl()).eq "https://github.com/#{repository.owner}/#{repository.name}"

  describe "#ownerUrl", ->
    repository =
        name: "fetch-service"
        owner: "customelements"
        description: ""
        forks: 0
        stars: 0

    it "returns github owner url", ->
      repo = new Repository(repository)

      expect(repo.ownerUrl()).eq "https://github.com/#{repository.owner}"
