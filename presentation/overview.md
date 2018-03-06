# Clean Git

How to keep your commit history clean.

## Why

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


## Why Not

1.  It may be that your team's workflow does not benefit from keeping a shorter
    commit history.
2.  It can be finicky to learn and hard to understand.
3.  You can really screw up your branch, other branches, you can lose commits
    (it has happened to me).
4.  Tendency to squash too much.  A 35 file change with only one commit can
    also be problematic.

## Examples

1.  Examples that are hard to work with:

    a.
    TODO: add examples here.


## A Bit About Commits and Branches

### What is a commit?

A commit records changes to a repository.  It describes changes from one state
to another state.  As long as git can find the things it needs to change, it
can apply a commit.  If it cannot, it will create a `conflict`.

(Show a commit) - https://github.com/enderlabs/eventboard.io/commit/00837a3cffcae8af37164ece206d91b3fe623894.patch

### What is a git branch?

Simplified, a branch is a list of commits, chained together. It describes
one change to another to another until now.

### Things to know

1.  Git _commits_ are **immutable**.  When you make a change to a commit (using
    `amend` or `rebase` or `reword` [more on these later]) the old commit still
    exists, and can be used, examined, etc. and you are creating a _new_
    commit.
2.  Git _history_ is mutable, in that it can be rewritten.
3.  Git _commits_ that are no longer referred to in a branch are _orphaned_,
    but can still be used in things like `show` and `cherry-pick`, until they
    are garbage collected.

### Why do you care?

Many of the techniques here are actually rewriting the bits of the branch
history.  When rewriting history, you _will_ end up orphaning existing commits,
and it can be useful to know that that are still there, at least for a while.

### WARNING!!!

Rewriting history is _destructive_.

**NEVER** rewrite git history on a main branch like `develop` or `master`, or
on a branch that someone else is developing (this is why it's often good to
make your own branch for your own work).  Rewriting git history **CAN** destroy
work.  If a coworker has one version of history on their local machine and pull
a newly rewritten history from GitHub or another server, there will often be
conflicts, commits inadvertently orphaned, etc.

As a general rule, until you know *exactly* what you are doing in this regard
(and even then, only if you have coordinated with other users of the branch
[which for branches like `master` and `develop` can be the entire dev team,
remote servers, etc]), only use these techniques on a branch that you, and you
alone, are using.  Once a branch has been merged/forked/etc, rewriting the
history of that branch **IS NOT SAFE**.

## Techniques

1.  `amend`.

    Add changes to the previous commit.

2.  `cherry-pick`.

    Apply a given commit to the current branch.  This commit can be any commit
    in the entire repository, in any branch.

3.  `rebase`.

    Re-apply commits on top of another base tip.  I will explain this more
    later.

4.  `interactive rebase`.

    The swiss army knife of rewriting git history.  You can reword messages,
    reorder commits, squash two or more commits together, remove commits, etc.


### AMEND

I don't know why, but this word just seems perpetually misspelled to me.

Amend creates a _new_ commit from the last commit on the branch and the staged
changes in the working tree.  Note that it does create a _new_ commit, it does
not modify the old commit, so that will still be there, and you are still
rewriting history.  Generally only do this if you haven't pushed to your branch
yet (or you are absolutely sure it hasn't been pulled anywhere else).

This is great for situations like:

1.  Oops, I forgot to `git add` a migration.
2.  Oops, my commit message is inadequate.
3.  Oops, there's a typo.

Example:

`git commit --amend -a`

This will give you a chance to edit your previous commit message and make any
changes you need to do.  This can be useful even if you don't have changes you
need to add to the commit, because you can reword your commit if needed.

### CHERRY-PICK

Grabs a commit from anywhere in the repository, and applies it to the current
branch.  Note that because git commits include information about their
ancestors, it is a _new_ commit, that matches the old one.  This is a
non-destructive operation.

You can apply commits from far back in history, from other branches, orphaned
commits, etc, as long as the code the commit references is reasonably similar
to the code that existed when the commit was created.  If someone else has
edited that code before the `cherry-pick`, you will get a conflict.

At this point, you can resolve the conflict the same way you would with a merge
conflict, and type `git cherry-pick --continue`, or you abort the operation by
typing `git cherry-pick --abort`.

Example:

`git cherry-pick 47b8a04faaf458e43907b4cff910df8ff0d2eb09`

You do not have to include the entire commit ID, you can include just enough
that git knows how to uniquely match it to a commit in the history.

Example:

`git cherry-pick 47b8a04`

### REBASE

For the purposes of keeping your PR clean, `rebase` is often used in place of a
`git merge origin/develop` or `git merge origin/master`.  It helps avoid merge
commits in the middle of your commit history.  For instance, in the following
scenario:

1.  You create a new branch based on `develop`:
    `git checkout mainline/develop && git checkout -b my-super-branch`.
2.  You make your changes and then commit them with
    `git commit -am 'super changes'`.
3.  In the meantime, someone pushes new commits to `develop`.

Here you have two options:

1.  `git fetch -a mainline && git merge mainline/develop`.  This will create a
    merge commit with all of the new changes, after the committed changes on
    your branch.  Your commit history will look something like:
    `develop -> my commits -> my commits -> merge develop -> my commits`
2.  `git fetch -a mainline && git pull --rebase mainline/develop`.  This will
    essentially uncommit your commits, pull down the develop with the new
    commits, and reapply your commits afterward.  Your commit history will look
    something like:
    `develop -> new develop -> my commits -> my commits`

This helps keep your commit history clean, but it also makes the next section,
`interactive rebase` a lot easier.

This is a destructive operation.  If you've pushed your branch somewhere and
someone else is using it, you rebase, and then push, it will mess with their
branch when they pull.

### INTERACTIVE REBASE

This is the most flexible, most destructive operation.  In general, you should
only do this if you don't have any merge commits in your branch history (which
you can avoid by using `rebase` as described in the last section).  If
any of the commits in the merge commit modify the same files, it will be very
difficult to get through this without fixing a bunch of conflicts.

You start the operation by typing `git rebase -i` followed by a target, which
is the commit where you want to start.  An editor will be displayed, allowing
you to rebase the commits since, and including, your target commit.

If you had a commit history similar to the following:

```
379c36564 Commit I don't want anymore
15a3a9748 More Documentation
26d431509 Code Changes
934a4791a Mispelled commit
3297e8697 Documentation Update
...       develop commits
```

You could type `git rebase -i HEAD~4`, which means "include the HEAD commit and
the 4 commits before it" for a total of the last 5 commits.  There are lots of
different ways of specifying the starting commit for the interactive rabase
operation, but this is the one I use most (to see others, visit:
https://git-scm.com/book/en/v2/Git-Tools-Revision-Selection).

When you type that, you will be presented with your default `$EDITOR` (which is
hopefully vim ;-)) and it will look like this:

```
pick 3297e8697 Documentation Update
pick 934a4791a Mispelled commit
pick 26d431509 Code Changes
pick 15a3a9748 More Documentation
pick 379c36564 Commit I don't want anymore

# Rebase 453116dac..379c36564 onto 453116dac (5 commands)
#
# Commands:
# p, pick = use commit
# r, reword = use commit, but edit the commit message
# e, edit = use commit, but stop for amending
# s, squash = use commit, but meld into previous commit
# f, fixup = like "squash", but discard this commit's log message
# x, exec = run command (the rest of the line) using shell
# d, drop = remove commit
#
# These lines can be re-ordered; they are executed from top to bottom.
#
# If you remove a line here THAT COMMIT WILL BE LOST.
#
# However, if you remove everything, the rebase will be aborted.
#
# Note that empty commits are commented out
```

As you can see, the commits listed are in reverse order, with the oldest commit
first, and the most recent commit last.  You see each commit in the following
format:

`command` `commit ID` `commit summary`

To make changes to the history, you edit this file.  You can change the order
of commits by simply moving them around.

To perform other operations on the commits, you simply change the `command` bit
to do what you want. The comments below your commits describe what each
`command` does.  If you leave it as `pick`, it will simply use the commit
as-is, without making any changes to it.

In the case of our commit history example above, we probably want to do the
following operations:

1.  Remove `379c36564` (Commit I don't want anymore).
2.  Reword the commit message for `934a4791a` (Mispelled commit) so that it is
    no longer misspelled.
3.  Combine `15a3a9748` (More documentation) with `3297e8697` (Documentation
    update).

To do that, you would change the top part of the editor to look like this:

```
pick 3297e8697 Documentation Update
squash 15a3a9748 More Documentation
reword 934a4791a Mispelled commit
pick 26d431509 Code Changes
drop 379c36564 Commit I don't want anymore
```

The following is equivalent:

```
pick 3297e8697 Documentation Update
s 15a3a9748 More Documentation
r 934a4791a Mispelled commit
pick 26d431509 Code Changes
```

And then save the file, exit the editor. For things like `squash` and `reword`,
you will be prompted to edit the commit message.
