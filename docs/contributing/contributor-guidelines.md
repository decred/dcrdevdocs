# <img class="dcr-icon" src="/img/dcr-icons/Question.svg" /> Contributor Guidelines

---

Decred development is, like the project, decentralized. Different projects and their repos can have their own own rules and norms. However, the general process for contributing across repos will be the same. Below we describe the basic process for finding work, engaging projects and the general GitHub process.

## Finding Work

Nearly all work occurs in public repos and is open to new contributors. A full list of repos can be found in the Decred [GitHub organisation](https://github.com/decred). A list of projects under active development and descriptions of them can be found on the [Projects](../projects.md) page. 

If new to the project, be sure to check out the user-facing [docs](https://docs.decred.org) to get an understanding of the basics of Decred. Then find a project that interests you and that you feel you have the skills to contribute to. Once you've found a project you're interested in, find an issue you'd like to work on. GitHub Issues tagged with `good first issue` are a good place to start. 

## Contributing

Once you've found something you'd like to work on, announce your plans **before** starting work.  This avoids duplicate work, minimizes the chances you're working on something that might not fit with the consensus of the community, and permits discussions that can help you achieve your goal. If working on a GitHub Issue, you can do this by commenting on the Issue. You can also speak with the relevent devs on Matrix. Most projects have a dedicated chat channel for discussing project-specific work.

Some repos will also have their own specific guidelines. For instance, the dcrd repo has fairly extensive [Code Contribution Guidelines](https://github.com/decred/dcrd/blob/master/docs/code_contribution_guidelines.md).

## GitHub

While different repos may have slightly different GitHub processes, below are the basic steps common to all repos.

1. Fork the repo on GitHub.
1. Clone the forked repo. 
1. Make your changes in a local branch.
1. When your changes are ready to be reviewed (or you just want input from other devs), push your branch to your forked repo and open a Pull Request (PR) on GitHub against the main repo. If your changes address an Issue, put `Closes #` or `Fixes #`in the PR description. This will allow GitHub to automatically close the Issue when the PR is merged. 
1. All changes must be reviewed and receive at least one approval before they can be merged. Only team members with write access on the repository can give official approval, but comments from other users are encouraged.
1. If a reviewer requests changes, make those changes in the local branch you were working in. Then push those changes to your forked repo. This will automatically update the PR in a way that allows the reviewer to see the changes you've made.
1. Once approved, your PR can be merged into master. To keep history clean, only non-fast-forward merges are allowed (i.e. we want a linear history). If a change consists of multiple commits, those commits typically must be squashed into a single commit. If there is a reason to include multiple commits in a PR, that will be considered on a case-by-case basis. 
1. If your PR consists of a single commit (or multiple commits that can be automatically squashed by GitHub), and has no conflicts with master, the reviewer will merge your PR. If your branch is too far behind master, you may be asked to rebase your commit and push again. 

