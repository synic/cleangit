# RESET

The `reset` command changes where the current `HEAD` is pointing.  For
instance, if you have a branch that looks like the following:

Given the following branch:

`A -> B -> C`

Where `A`, `B`, and `C` are commits on your branch, and you type `git
reset B`, your branch will now be `A -> B`, and the changes in `C` will be in
your working directory (essentially uncommitting C).

If you typed `git reset A` instead, your branch would just be `A`, and the
changes of both `B` and `C` would be in your working directory.


## __SOFT__

`git reset --soft` will do the same as above, but the changes in the
uncommitted commits will be staged in your working directory.

## __MIXED__

This is the default.  `git reset --mixed` (or `git reset`) is the same as
`soft`, except the changes will _not_ be staged in the working directory.

## __HARD__

This is the same as above, except the changes in the uncommitted commits will
be **LOST**.

## __Why is this useful?__

Imagine the following scenario.  You have two files in your working directory,
`main.c`, and `README.md`.  You type something like the following:

```text
$ git add main.c README.md
$ git commit -m "add initial files"
```

After you commit, you realize that you want to split it into two commits,
"adding source files", and "adding README.md".  You could do something like the
following:

```text
$ git reset HEAD^
$ git add main.c
$ git commit -m "adding source files"
$ git add README.md
$ git commit -m "adding README.md"
```
