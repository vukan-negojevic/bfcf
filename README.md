butterfleye-crowdfunding
========================

## Deployment to Heroku:

- Demo app is at http://butterfleye-demo.herokuapp.com (git remote: `demo`)
- Production app is at http://butterfleye.herokuapp.com (git remote: `production`)

## Workflow:

- Local development happens on the `develop` branch.
- Push to `master` on the demo environment from the `develop` branch only: 
```
git push demo develop:master
```
- Merge changes to `master` branch once they're ready to deploy to `prod`:
```
git co master
git merge develop
```
- Push to `master` on the `production` environment from `master` only:
```
git push production master
```

## Configuration:

Both apps run in the `production` Rails environment. App-specific settings should be configured via Heroku environment variables.
