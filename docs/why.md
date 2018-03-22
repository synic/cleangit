# Why

*   It gives you the ability to separate your commits into logical blocks. For
    example, you may want to keep your logical changes separate from your style
    changes separate from your configuration changes.
*   Reverting.  It is much easier to revert your changes if they are in a
    smaller number of commits, as opposed to a larger number with lots of merge
    commits.
*   Sometimes you want to bring some changes from one branch to
    another, and bringing a few commits over is a lot easier than bringing a
    lot of commits.  More on this later.
*   These techniques can be used to fix broken PRs, help you create new PRs
    from old PRs (maybe ones that didn't get merged for whatever reason), and
    are generally easier to read.
