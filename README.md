# CustomElements.io — Fetch Service

This project is responsible to generate the Web Components list on [CustomElements.io](http://customelements.io) by following these steps:

1. Grabs the [static list of Web Components](https://github.com/customelements/customelements.io/blob/gh-pages/data/repos.json).
2. Fetches all the information from the GitHub API based on that list.
3. Merge this list with all [Bower components tagged with web-components](https://bower-component-list.herokuapp.com/keyword/web-components).

> **Maintainer:** [Djalma Araújo](https://github.com/djalmaaraujo)

# Requirements
- Node
- Redis

# Environment vars
```bash
export REDISTOGO_URL
export BOWER_API_URL
export CUSTOMELEMENTS_API_URL
export GITHUB_API_URL
export GITHUB_USERNAME
export GITHUB_PASSWORD
```

# Installation
```bash
git clone git@github.com:customelements/fetch-service.git
npm install
```

# Run
```bash
node server
```

# Deploy
```bash
git push heroku master
```

## License

[MIT License](http://djalmaaraujo.mit-license.org/) © Djalma Araújo
