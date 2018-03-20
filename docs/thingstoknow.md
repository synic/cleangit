# Things to know

1.  Git _commits_ are **immutable**.  When you make a change to a commit (using
    `amend` or `rebase` or `reword` [more on these later]) the old commit still
    exists, and can be used, examined, etc. and you are creating a _new_
    commit.
2.  Git _history_ is mutable, in that it can be rewritten.
3.  Git _commits_ that are no longer referred to in a branch are _orphaned_,
    but can still be used in things like `show` and `cherry-pick`, until they
    are garbage collected.
