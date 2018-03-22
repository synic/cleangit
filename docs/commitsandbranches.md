# A Bit About Commits and Branches

## __What is a commit?__

A commit records changes to a repository.  It describes changes from one state
to another state.  As long as git can find the things it needs to change, it
can apply a commit.  If it cannot, it will create a `conflict`.

[commit example](https://github.com/enderlabs/eventboard.io/commit/00837a3cffcae8af37164ece206d91b3fe623894.patch)

<br>

## __What is a git branch?__

Simplified, a branch is a list of commits, chained together. It describes
one change to another to another until now.

![branch](images/branch.png)
