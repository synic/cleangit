# Clean Git

How to keep your commit history clean.

### Why

1.  It gives you the ability to separate your commits into logical blocks. For
    example, you may want to keep your logical changes separate from your style
    changes separate from your configuration changes.
2.  Reverting.  It is much easier to revert your changes if they are in a
    smaller number of commits, as opposed to a larger number with lots of merge
    commits (show example TODO: add example).
3.  `cherry-pick`.  Sometimes you want to bring some changes from one branch to
    another, and bringing a few commits over is a lot easier than bringing a
    lot of commits.  More on this later.
4.  These techniques can be used to fix broken PRs, help you create new PRs
    from old PRs (maybe ones that didn't get merged for whatever reason), and
    are generally easier to read.


### Why Not

1.  It may be that your team's workflow does not benefit from keeping a shorter
    commit history.
2.  It can be finicky to learn and hard to understand.
3.  You can really screw up your branch, other branches, you can lose commits
    (it has happened to me).
4.  Tendency to squash too much.  A 35 file change with only one commit can
    also be problematic.

### Examples

1.  Examples that are hard to work with:

    a.
    TODO: add examples here.


### A Bit About Commits

#### What is a commit?

A commit records changes to a repository.  It describes changes from one state
to another state.  As long as git can find the things it needs to change, it
can apply a commit.  If it cannot, it will create a `conflict`.

(Show a commit) - https://github.com/enderlabs/eventboard.io/commit/00837a3cffcae8af37164ece206d91b3fe623894.patch

#### What is a git repository?

Essentially, a repository is a list of commits, chained together. It describes
one change to another to another until now.
