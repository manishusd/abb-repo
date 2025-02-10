# Main Branches

1. **master**: The production-ready branch. This branch will be deployed to both the demo and prod environments.

# Supporting Branches

1. **Release/**: Created based on features decided for a release. Developers work on this branch using their respective "Feature" branches. This branch will be deployed to dev and QA environments.
2. **Feature/**: Created from Release/* by a developer for a specific task/user story related to that particular release.
3. **Bugfix/**: Created from the Release/* branch by a developer to address any bugs found during ongoing feature development.
4. **Hotfix/**: Created from master for critical bug fixes in production or demo environments.

### Workflow

# 1. Feature Development
- Create a Release/* branch from master based on the decided features.
- Developers create Feature/* branches from the Release/* branch for their specific tasks.
- Developers can continuously test their work with the Feature/* branch, which will be deployed to the dev test environment, a clone of dev2.
- Once a feature is completed, merge it back into the Release/* branch.
- Before completing the PR to the Release/* branch and making it available for release into the dev environment after completing your feature, ensure you pull the latest changes from the master branch. This is important because there may have been hotfixes applied directly to the master branch for the demo environment. These changes might not be present in your Release/* branch.

# 2. Release Process
- Once the release-related work is fully completed, the Release/* branch will be deployed to the dev environment for initial testing.
- After initial testing, the Release/* branch will be deployed to the QA environment.
- QA tests the Release/* branch. Once this is approved by QA and the Change Control Board (CCB) decides on a production release, merge the Release/* branch into master.

# 3. Deployment
- The master branch is deployed to the demo environment for UAT testing.
- After successful UAT testing in the demo environment, the master branch is deployed to production.

# 4. Hotfix Workflow
- If a bug is found in the demo or production environment, create a Hotfix/* branch from the master branch.
- Fix the bug in the Hotfix/* branch.
- Merge the Hotfix/* branch back into master.

# 5. Handling Parallel Releases
- If there are two features going in parallel, two Release/* branches will be created.
- The second Release/* branch (e.g., Release2) will be created from the first Release/* branch (e.g., Release1) if it is available and not deleted after merging the first release to master. Otherwise, it can be created from master.
- The process will be the same for Release2 as it was for Release1.

