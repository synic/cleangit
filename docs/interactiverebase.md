# INTERACTIVE REBASE

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
