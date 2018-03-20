# CHERRY-PICK

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
