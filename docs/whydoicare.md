# Why do you care?

Many of the techniques here are actually rewriting the bits of the branch
history.  When rewriting history, you _will_ end up orphaning existing commits,
and it can be useful to know that that are still there, at least for a while.

# WARNING!!!

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
