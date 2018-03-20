# AMEND

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
