# Github Repository
Stands up a new github repository following some standard rules and gitflow patterns. It also removes a lot of unnecessary repo settings by default.

Repo Settings
- has issues = false
- has discussions = false
- has wiki = false
- has downloads = false
- archive on destroy = true (will not delete repo, just archive)
- delete branches on merge = true (prevent branch spam)
- auto init = true (setup repo with readme)
- allow squash merge = false
- allow rebase merging = false

It establishes 3 total branches
- Develop
- Staging
- Main

Each of these branches has it's own rule sets. None are user or team specific by default


*Develop*
- Allow force pushes = true
- Allow deletion = false


*Staging*
- Allow force pushes = false
- Allow deletion = false
- dismiss stale PR's = true
- require approvals = 1


*Main*
- Allow force pushes = false
- Allow deletion = false
- dismiss stale PR's = true
- require approvals = 1
