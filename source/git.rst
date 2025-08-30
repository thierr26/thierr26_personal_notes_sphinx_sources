Git
===

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell


Introduction
------------

Git (a `distributed version control system
<https://en.wikipedia.org/wiki/Distributed_version_control>`_) is complex and
it's easy to forget how to exactly do this or that. This page is where I note
the Git commands and configuration items I came across. Git commands usually
have many options, which are not all documented here, far from it. The true
`Git documentation <https://git-scm.com/docs>`_ gives all the details.


Installation
------------

.. index::
  pair: Git; installation

On a `Debian GNU/Linux <https://www.debian.org>`_ system, install Git (**as
root**) with::

  apt-get install git # As root.


Configuration
-------------


Minimal post-install configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index::
  triple: Git; global; configuration
  pair: Git; credential helper
  pair: Git; editor
  pair: Git; config
  single: chmod

After installing Git, user name and e-mail address should be configured::

  git config --global user.name "My Name"
  git config --global user.email "my.id@example.com"

If unfortunately you have done a commit with a wrong name and/or e-mail
address, the following command may fix the problem::

  git commit --amend --author="My Name <my.id@example.com>"

You may also want to specify the editor to be used for commit messages or tag
messages editor. Example with editor Vim::

  git config --global core.editor "vim"

You should probably also configure the actions of the ``git push`` and ``git
pull`` commands, as well as the default branch name.

For ``git push``::

  git config --global push.default simple

(See the `Git push documentation
<https://git-scm.com/docs/git-config#Documentation/git-config.txt-pushdefault>`_).

For ``git pull``::

  git config --global pull.ff only

(See this `tip by Sal Ferrarello
<https://salferrarello.com/git-warning-pulling-without-specifying-how-to-reconcile-divergent-branches-is-discouraged>`_).

For the default branch name::

  git config --global init.defaultBranch master

You can see your Git configuration with::

  git config --list

If you use a git hosting service like `GitHub <https://github.com/>`_,
`GitLab <https://about.gitlab.com/>`_ or `Bitbucket <https://bitbucket.org/>`_,
you may want Git to store your credentials for the service. One way to achieve
that is to use the Git credential helper.

The following command causes Git to store the credentials you provide next time
you issue a (for example) ``git push`` command, so that you won't ever have to
retype them::

  git config --global credential.helper store

The credentials are stored in ``~/.git-credentials``. **They are not
encrypted**, so check that only you have read permission on that file (if this
is not the case, issue a ``chmod 600 ~/.git-credentials`` command).

Alternatively, you can use the "cache" credential helper. The following command
causes Git to cache the credentials for 20 minutes (1200 seconds)::

  git config --global credential.helper 'cache --timeout 1200'


.. _git_aliases:

Creating aliases
~~~~~~~~~~~~~~~~

.. index::
  triple: Git; global; configuration
  pair: Git; config
  pair: Git; aliases

Create aliases with commands like::

  git config --global alias.ci commit # Creates alias "ci" for command
                                      # "commit".

  git config --global \
      alias.g 'log --pretty=oneline --abbrev-commit' # Creates alias "g" for
                                                     # command "log" with
                                                     # options for compact
                                                     # output.

Alternatively, you can edit the aliases directly in file ``~/.gitconfig``.

Some aliases can invoke shell commands. See for example the "release" alias in
`my ~/.gitconfig file
<https://github.com/thierr26/thierr26_config_files/blob/master/.gitconfig>`_.


Splitting the configuration file
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index::
  pair: Git; configuration file split
  pair: Git; configuration file [include] section
  single: ~/.gitconfig

All the ``git config --global`` commands mentioned above actually create
entries ("config directives") in file ``~/.gitconfig``. You may want to store
some entries in one or more separate files. Create an ``[include]`` section in
your ``~/.gitconfig`` file for that. `Travis Jeffery gives more details
<http://travisjeffery.com/b/2012/03/using-git-s-include-for-private-configuration-information-like-github-tokens/>`_.


Local configuration
~~~~~~~~~~~~~~~~~~~

.. index::
  triple: Git; local; configuration

Configuration entries can be created in the repository local configuration
(file ``.git/config``) by using the ``--local`` option instead of the
``--global`` option in the ``git config`` commands. Repository local
configuration can be used to define smudge and clean filters (see
:ref:`git_maintain_work_commit_diff`).


Working with a separate repository
----------------------------------

.. index::
  pair: Git; separate Git directory

This command::

  git init --separate-git-dir path/to/separate_git_dir.git

creates an empty Git repository like ``git init`` but does not create a
``.git`` repository in the current directory. It creates
``path/to/separate_git_dir.git`` instead (plus a ``.git`` *file* in the current
folder containing the path to the actual repository). The same command *moves*
the repository to the specified location if it already exists.

The ``--git-dir`` option can be used in any Git command to specify the path to
the repository. Useful for cases where the working directory does not contain
any ``.git`` directory or file (and this can happen if the working directory is
an artifact of a build process and is cleaned out and regenerated by, say, a
``make clean html`` command (case of a `Sphinx
<http://www.sphinx-doc.org/en/master>`_ HTML project)). Example::

  git --git-dir=path/to/separate_git_dir.git status


Working from outside the working directory
------------------------------------------

.. index::
  pair: Git; from outside the working directory

The ``-C`` switch can be used in any Git command to specify the path to the
working directory. Example::

  git -C path/to/working/directory status

The ``-C`` switch and the ``--separate-git-dir`` or ``--git-dir`` options can
be combined.

The following command initializes a repository whose working directory is in
the ``build/html`` subdirectory and the separate repository is
``.git_build_html`` in the current directory::

  git -C build/html init --separate-git-dir ../../.git_build_html

The following command is a ``git status`` command applied to a repository whose
working directory is in the ``build/html`` subdirectory and the separate
repository is ``.git_build_html`` in the current directory::

  git -C build/html --git-dir ../../.git_build_html status


Cloning an existing repository
------------------------------


Cloning to a new directory
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index::
  pair: Git; clone

Clone a repository to a new directory with commands like::

  git clone repository_url
  git clone user_name@repo.host:path/to/repo # scp-like syntax if you can use
                                             # SSH to connect to the repository
                                             # host.

Force the name of the cloned repository by providing the name as a
supplementary argument::

  git clone repository_url cloned_repository_name

It is also possible to clone and check out a specific branch::

  git clone -b branch_name repository_url

Use option "--recurse-submodules" to also initialize and clone all the
submodules::

  git clone --recurse-submodules repository_url

You can also clone without checking out anything::

  git clone -n repository_url


Cloning in an existing directory
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index::
  pair: Git; init
  pair: Git; pull
  pair: Git; remote

Sometimes you want to turn an existing directory into a clone of a Git
repository. It is possible with a sequence of commands like::

  cd dir/to/turn/into/a/clone          # Move to the directory.
  git init                             # Create an empty Git repository.
  git remote add origin repository_url # Configure the remote.
  git pull origin master               # Pull master branch.

The ``git pull origin master`` command fails if it has to overwrite existing
local files. If you really want a clone of the remote repository, remove the
local files and run the ``git pull origin master`` command again.


Making a repository shareable
-----------------------------

.. index::
  single: groupadd
  single: chgrp
  single: chmod
  single: find
  single: usermod
  pair: Git; shared repository

I've been once in a situation where I had a local repository tracking a `bare
remote repository
<http://www.saintsjd.com/2011/01/what-is-a-bare-git-repository/>`_ on the same
Linux machine. The remote had been initialized (``git init --bare ...``) by me
(as a "normal" user). When other users on the machine have tried to push to the
remote, they couldn't because they didn't have the permission and because the
repository had not been configured to be shareable. We decided to create a
group (called "develop" in the commands below) and to make sure the members of
the group had the permission to push to the remote. We could achieve that with
the following commands.

As root::

  groupadd develop                       # Create group.

As me ("normal" user)::

  cd /path/to/bare/remote/repository
  git config core.sharedRepository group # Make repository shareable.

As root::

  cd /path/to/bare/remote/repository
  chgrp -R develop .                     # Change files and directories' group.
  chmod -R g+w .                         # Give write permission to group...
  chmod g-w objects/pack/*               # Expect for pack files.
  find -type d -exec chmod g+s {} +      # New files get directory's group id.
  usermod -aG develop my_username        # Add me to group.
  usermod -aG develop other_user         # Add another user to group, etc...


.. _git_staging:

Staging changes
---------------

.. index::
  pair: Git; stage
  triple: Git; stage; dry run
  pair: Git; add
  pair: Git; rm
  pair: Git; .gitignore

``git add -A`` stages all changes (including new files and file removals).
``git add .`` is equivalent to ``git add -A`` (except with Git version 1.x
(file removals not staged)).

``git add --ignore-removal`` does not stage file removals.

``git add -u`` does not stage new files.

Use the ``-p`` switch to stage only parts of the changes made to a file
(interactive command)::

  git add -p path/to/file

The following commands stage the removal of a file::

  git rm path/to/file

  git rm --cached path/to/file # Does not remove the file from the working
                               # directory.

``git status`` shows the staged files (among other things).

Note also that there is a dry run option for ``git add``. This is the ``-n``
switch. The following command *shows* what *would* be staged but does not
actually stage::

  git add -n .

This comes especially handy when you want to :ref:`ignore files and/or
directories <gitignore>` and you are not sure the ``.gitignore`` file is
correct.


Unstaging changes
-----------------

.. index::
  pair: Git; unstage
  pair: Git; reset

You can unstage a file that you have just mistakenly staged with a command
like::

  git reset -- path/to/file


.. _gitignore:

Ignoring files and directories
------------------------------

.. index::
  pair: Git; ignore
  pair: Git; .gitignore
  pair: Git; .git/info/exclude

Quiet often there are files and/or directories in the working directory that
shouldn't be tracked by the version control system. Such files and/or
directories must be mentioned in file ``.gitignore`` or in file
``.git/info/exclude``. ``.gitignore`` is tracked, ``.git/info/exclude`` is not.
Of course, you can mention some of the files/directories to be ignored in
``.gitignore`` and the others in ``.git/info/exclude``.

The official documentation provides information on the `patterns that can be
used in .gitignore <https://git-scm.com/docs/gitignore#_pattern_format>`_.

Sometimes, you want to ignore everything except a few files. For example, a
``.gitignore`` file with the following content would cause the whole working
directory to be ignored, except:

* file ``.gitignore``
* file ``file_1``;
* file ``file_2``;
* file ``dir_a/subdir/file_3``;
* file ``dir_a/subdir/file_4``.
* all files and directories in directory ``dir_b`` with infinite depth.

| /*
| !.gitignore
| !file_1
| !file_2
| dir_a/*
| !dir_a
| dir_a/subdir/*
| !dir_a/subdir
| !dir_a/subdir/file_3
| !dir_a/subdir/file_4
| !dir_b


Showing changes
---------------

.. index::
  pair: Git; diff
  pair: Git; log

Show the difference between what is staged (or what is in the last commit if no
change is staged) and the working tree with::

  git diff

  git diff -- path/to/files # Shows changes for the specified files only.

Show the difference between the last commit of branch "branch_name" and the
working tree with::

  git diff branch_name

  git diff branch_name -- path/to/files # Shows changes for the specified files
                                        # only.

Assuming at least one of the path is outside the working tree, the following
command shows the difference between the two files::

  git diff path/to/file other/path/to/file

Show the difference between what is staged and the last commit with::

  git diff --staged

  git diff --staged -- path/to/file # Shows changes for the specified files
                                    # only.

Show the difference between a particular commit and the working tree with
commands like::

  git diff 42b9c3b

  git diff 42b9c3b -- path/to/files # Shows changes for the specified files
                                    # only.

Show the difference between two particular commits with commands like::

  git diff 42b9c3b a92c02a

  git diff 42b9c3b a92c02a -- path/to/files # Shows changes for the specified
                                            # files only.

You can get a compact overview of the difference using some ``git diff``
options::

  git diff --stat
  git diff --numstat

In some cases, ``git log -p`` can be a good alternative to ``git diff``::

  git log -p -1 a92c02a -- path/to/files # Shows log message and changes made
                                         # for commit a92c02a.

You sometimes want to filter the output of git diff. The ``-G`` and ``-S``
options can help.

* `Documentation for git diff -S option
  <https://git-scm.com/docs/git-diff#Documentation/git-diff.txt--Sstring>`_,

* `Documentation for git diff -G option
  <https://git-scm.com/docs/git-diff#Documentation/git-diff.txt--Gregex>`_.

If you don't want to see the lines changed by the addition or the removal of
whites spaces only, use option ``-w`` (equivalent to ``--ignore-all-space``)::

  git diff -w

If you want to see only the names of the changed files, do::

  git diff --name-only 42b9c3b a92c02a # Shows names of changed files only.

The output of a ``git diff`` command is a patch that can be used as input to
the ``git apply`` command::

  git diff > my_patch
  git apply my_patch

A patch may be applicable or not. Use the ``--check`` option of ``git apply``
to see if the patch is applicable or not::

  git apply --check my_patch

There is an alternative to ``git diff`` which is ``git difftool``, that you can
configure to use a specific tool to show differences between files (e.g. `Meld
<https://meldmerge.org>`_). A `Stackoverflow answer provides all the details
about using Meld as the Git difftool (and mergetool too)
<https://stackoverflow.com/questions/34119866/setting-up-and-using-meld-as-your-git-difftool-and-mergetool>`_.


Committing
----------

.. index::
  pair: Git; commit
  pair: Git; amend
  pair: Git; cherry-pick

The following commands commit the staged changes to the repository::

  git commit                                 # Opens a text editor for commit
                                             # message edition.

  git commit -m "Commit message"             # Takes the commit message from
                                             # the command line.

  git commit -F path/to/commit/message/file  # Reads the commit message from a
                                             # file.

  git commit -eF path/to/commit/message/file # Reads the commit message from a
                                             # file and opens the text editor
                                             # for commit message edition.

With the ``-a`` switch, all the changes (except file addition) are staged
before committing::

  git commit -a

A commit that has not been already pushed to a remote can be amended, that is
you can :ref:`stage changes <git_staging>` and then create a commit that
contains the changes already committed and the new changes. This new commit
replaces the previous commit. Use the ``--amend`` option to create the new
commit::

  git commit --amend
  git commit --amend --no-edit # Reuse existing commit message.

By default, you can't do a commit that does not change anything in the tree (an
"empty" commit) and you can't do a commit without a commit message. If you
really want to do one of those things, you have to use the ``--allow-empty``
or ``--allow-empty-message`` respectively. An empty commit is interesting for
example as the first commit of a project. Having an empty commit as first
commit makes it possible to a `create an empty new branch if needed
<https://stackoverflow.com/questions/15034390/how-to-create-a-new-and-empty-root-branch>`_.

When needing to do a commit which is equivalent to commit already done in
another branch, ``git cherry-pick`` comes in handy::

  git cherry-pick commit_hash_of_the_existing_commit


Tagging
-------

.. index::
  pair: Git; tag
  pair: Git; ls-remote
  pair: Git; rev-list

Basic tag manipulations (creation, deletion) are done using the ``git tag``
command and its various option. But there are more things to do with tags
(cloning, pushing). `A Stack Otherflow answer gives many details about tagging
in Git <https://stackoverflow.com/a/35979751>`_.

Note also the following commands, useful to find tags and corresponding
commits::

  git log -1 my_tag           # Show local branch commit for tag "my_tag".
  git ls-remote --tags origin # List commit hash / tag pairs for remote
                              # "origin".

With ``git rev-list``, you get only the commit hash::

  git rev-list -1 my_tag

And if you need to know whether the currently checked out commit has a tag or
not, use::

  git describe --exact-match --tags


Viewing the commit log
----------------------

.. index::
  triple: Git; log; compact
  triple: Git; log; graph
  triple: Git; log; commit date formatting
  triple: Git; log; commit hash
  pair: Git; show
  pair: Git; rev-list

Show the commit log with::

  git log

When using a Git version older than 2.13, you need to add option
``--decorate`` to see references names (branch heads and tags) in the log.

The ``log`` command is extremely configurable. I have
:ref:`aliases <git_aliases>` for those variants::

  git log --pretty=oneline --abbrev-commit # Compact output.

  git log --graph --oneline --all          # Compact graphical representation.

You can limit the number of commits shown. Example with a limit set to 4::

  git log -4

You can limit the ``git log`` output to a range of commits using the "double
dot" syntax (note that **the first hash must be the one of the commit preceding
the first commit of the range!**)::

  git log 9369edb..1989336

You can also add various overviews of the changes done in the commits::

  git log --stat
  git log --numstat
  git log --name-only
  git log --name-status

For the record, here are a few more examples for ``git log`` (for commit
hashes, dates and commit message as raw text)::

  git log --pretty="%H" -1     # Commit hash.
  git log --pretty="%h" -1     # Short commit hash.
  git log --pretty="%ci %H" -1 # Committer date (ISO 8601 like) and hash.
  git log --pretty="%cI" -1    # Committer date (strict ISO 8601 format).
  git log --pretty="%cD" -1    # Committer date (RFC2822 style).
  git log --pretty="%B" -1     # Commit message as raw text (subject and body).
  git log --pretty="%b" -1     # Commit message as raw text (body only).

In ``%ci`` or ``%cI``, the letter c stands for "committer date". Use letter a
instead of letter c for the "author date".

When interested in a specific commit, ``git show`` can be used instead of ``git
log``::

  git show -s git log --pretty="%ci %h" e66cceb

``git rev-list branch_name`` shows the commit hashes in reverse chronological
order for the branch "branch_name". Some options make it possible to filter by
date. Example::

  git rev-list -1 --before "2025-01-19 11:48" master # Most recent commit
                                                     # before a date.


Working with remote repositories
--------------------------------

.. index::
  pair: Git; remote
  pair: Git; push
  pair: Git; fetch
  pair: Git; pull

Configure a remote named "origin" with::

  git remote add origin remote_repository_url
  git remote add -t branch_name origin remote_repository_url # Track only
                                                             # branch
                                                             # branch_name.

Check the configured remotes with::

  git remote -v

The following commands also show interesting information about remote::

  git remote show
  git remote show remote_name
  git branch -vv

Push the commits in the "master" branch to "origin" with::

  git push origin master

The following commands download changes from "origin" (but does not affect the
history of the local repository)::

  git fetch origin
  git fetch        # "origin" is the default remote.

If you have multiple remotes, you can fetch them all with::

  git fetch --all

The following commands fetch changes from the given repository for branch
"master" and merges the changes into the local repository::

  git pull origin master                   # Download from remote named
                                           # "origin".

  git pull <repository_url_or_path> master # Specify the repository using an
                                           # URL or a directory path.

The following command downloads changes from the branch "branch_name" of remote
"origine" and updates the local branch, no need to check out "branch_name"::

  git fetch origin branch_name:branch_name

You can list the URLs for remote "origin" with::

  git remote get-url --all origin

You can change the URL for remote "origin" with a command like::

  git remote set-url origin url

You can remove a remote with::

  git remote rm remote_name


Case of SSH access
~~~~~~~~~~~~~~~~~~

.. index::
  pair: Git; Through SSH
  pair: Git; In a Jenkins pipeline
  pair: Git; GIT_SSH_COMMAND
  pair: Jenkins; withCredentials
  pair: Jenkins; withEnv
  pair: SSH; For Git server access

You might need to specify the SSH key to use. The following links should help:

* `How to tell git which private key to use?
  <https://superuser.com/questions/232373/how-to-tell-git-which-private-key-to-use>`_
* `Managing multiple SSH keys
  <https://www.syedaslam.com/managing-multiple-ssh-keys/>`_
* `Push git changes through ssh (in a Jenkins pipeline)
  <https://wiki.autopdutop.fr/jenkins/jenkinsfile/#push-git-changes-through-ssh>`_


Working with branches
---------------------

.. index::
  pair: Git; branch
  pair: Git; fetch
  pair: Git; push
  pair: Git; checkout
  pair: Git; rebase
  pair: Git; commit
  pair: Git; merge
  pair: Git; fast-forward
  pair: Git; squash

``git status`` shows the current branch (among other things).

To list the branches, use::

  git branch    # List the local branches.
  git branch -a # Also includes the remote-tracking branches.
  git branch -r # Includes only the remote-tracking branches.

Adding option ``-v`` causes the commit hash and commit subject line to be shown
for each branch head.

Switch to branch named "branch_name" with::

  git checkout branch_name

  git checkout -b branch_name       # Creates the branch named "branch_name".

  git checkout --orphan branch_name # Creates an orphan branch (note that the
                                    # files of the branch the orphan branch is
                                    # started from are automatically staged).

This of course raises the question of which branching model and branche naming
scheme to use. The following links should help:

* `What are some examples of commonly used practices for naming git branches?
  (a stack overflow answer by Phil Hord)
  <https://stackoverflow.com/questions/273695/what-are-some-examples-of-commonly-used-practices-for-naming-git-branches/6065944#6065944>`_
* `4 branching workflows for Git
  <https://medium.com/@patrickporto/4-branching-workflows-for-git-30d0aaee7bf>`_
* `Git-flow, a successful Git branching model
  <https://nvie.com/posts/a-successful-git-branching-model/>`_
* `A stable mainline branching model for Git
  <https://www.bitsnbites.eu/a-stable-mainline-branching-model-for-git/>`_
* `Git Branching Strategies vs. Trunk-Based Development
  <https://launchdarkly.com/blog/git-branching-strategies-vs-trunk-based-development/>`_
* `Work-In-Progress (WIP) commits: a git technique in Trunk-Based Development
  <https://www.dmitriydubson.com/post/trunk-dev-wip-commits/>`_

Working with branches, you inevitably have to do some merging (using the ``git
merge`` command) or rebasing (using the ``git rebase`` command). Rebasing is
not always easy. I found `this article by Chris Jones
<https://www.viget.com/articles/how-to-fix-your-git-branches-after-a-rebase>`_
very enlightening, with a clear explanation of the ``--onto`` option of ``git
rebase``.

I usually use ``git rebase`` in commands like the following ones. See
`Filippo Vasorda's post
<https://blog.filippo.io/git-fixup-amending-an-older-commit>`_ for explanations
about the ``git commit --fixup`` / ``git rebase`` combination)::

  git rebase branch_name                 # Rebases the current branch on the
                                         # latest commit of branch
                                         # "branch_name".

  git rebase --onto branch_name old_base # "Moves" the commits of the current
                                         # branch (starting with the commit
                                         # following "old_base") to the "top"
                                         # of "branch_name".

  git commit --fixup=target_commit \
      && git rebase -i -autosquash commit_before_target_commit

The ``--update-refs`` option, introduced with Git 2.38, may make your life much
easier, especially if you use stacked branches. See `this article by Andrew
Lock
<https://andrewlock.net/working-with-stacked-branches-in-git-is-easier-with-update-refs/>`_.

Merge the branch named "branch_name" into the current branch with one of the
following commands::

  git merge --no-ff branch_name # Creates a merge commit.

  git merge branch_name         # Does not create a merge commit when the merge
                                # resolves as fast-forward.

If you want to determine whether the merge of the branch "branch_name" into the
current branch will resolve as fast-forward or not, you can issue a command
like the following one and check the exit status (0 means that the merge will
resolve as fast-forward)::

  git merge-base --is-ancestor \
      <current_commit_hash> <commit_hash_of_last_branch_name_commit>
  echo $?

It is possible to merge all changes on the branch named "branch_name" into the
current branch without keeping the commit history::

  git merge --squash branch_name # A "git commit" command is needed after that
                                 # to actually create a merge commit.

Delete the local branch named "branch_name" with one of the following
commands::

  git branch -d branch_name # Does not delete the branch if it's not fully
                            # merged.

  git branch -D branch_name # Deletes the branch even if it's not fully merged.

After a branch deletion on origin, you probably need to do (locally)::

  git fetch origin --prune
  git branch --unset-upstream

To push a branch to origin, do::

  git push -u origin branch_name

Rename the local branch named "old_name" to "new_name"::

  git branch -m old_name new_name

Check out a file from another branch with a command like::

  git checkout branch_name -- path/to/file

To find the branch that contains a specific commit::

  git branch -a --contains commit_hash


Stashing changes
----------------

.. index::
  pair: Git; stash

Store the current state of the working tree and the index in the stash stack
and go back to a clean working tree with one of the following commands::

  git stash push
  git stash                       # Equivalent to "git stash push".
  git stash push -m "Description" # Provides a descriptive message.

If you don't want to revert the staged changes, use the ``--keep-index``
option::

  git stash push --keep-index

Use option "--include-untracked" to also stash the untracked files::

  git stash --include-untracked

Each ``git stash push`` command creates a new entry in the stash stack.

List the stash entries with::

  git stash list

Inspect a stash entry with a command like one of the following::

  git stash show stash@{0}
  git stash show -p stash@{0} # Produces a patch-like output.

Extract changes for a specific files from the stash with a command like::

  git checkout stash@{0} -- path/to/file

Remove an entry from the stash stack and apply the changes to the working tree
with a command like::

  git stash pop stash@{0}
  git stash pop           # Equivalent to "git stash pop stash@{0}".

You can also remove one entry (or even all the entries) from the stash stack
without applying the changes to the working tree::

  git stash drop stash@{0}
  git stash drop           # Equivalent to "git stash drop stash@{0}".
  git stash clear          # Remove all the stash entries.

Use the ``--index`` option to also reapply the staging::

  git stash pop --index


Exploring the repository
------------------------

.. index::
  pair: Git; ls-tree
  pair: Git; ls-files
  pair: Git; rev-parse
  pair: Git; top level directory

You can see the list of files and directories under version control in the
current directory using::

  git ls-tree HEAD

Add option ``-r`` to explore recursively the subdirectories, and option
``--name-only`` to see only the file names and hide the other informations::

  git ls-tree -r --name-only HEAD

Of course, you can use a specific commit hash instead of ``HEAD``.

If you need to search a file based on its file name, you can use a command
like::

  git ls-files "*abc*"

  git ls-files \
      $(git rev-parse --show-toplevel)/"*abc*" # Search from repository top
                                               # directory.

  git ls-files -s "*abc*"                      # Search in staged files.


Finding text patterns in the indexed files (or in any directory tree)
---------------------------------------------------------------------

.. index::
  pair: Git; grep
  pair: Git; log
  pair: Git; for-each-ref

Use commands like the following ones to search text patterns::

  git grep <reg_exp>            # Search regular expression <reg_exp> in
                                # indexed file.

  git grep <reg_exp> <subdir>   # Restrict search to subdirectory <subdir>.

  git grep -i <reg_exp>         # Case insensitive search.

  git grep -untracked <reg_exp> # Search also untracked files.

  git grep --no-index <reg_exp> # Useful to search in a directory which is not
                                # a Git repository.

To search text in all branches, an option is to use the ``-p`` and ``-G`` (or
``-S``) options of ``git log``, as explained in `this Stack Overflow answer by
Edward Anderson <https://stackoverflow.com/a/26226807>`_. Another option is to
do something like::

  git grep pattern `git for-each-ref --format='%(refname)' refs/heads`


Find the last modification date and author of any line of a file
----------------------------------------------------------------

.. index::
  pair: Git; blame

Use this command to see the last modification date and author of any line of a
file::

  git blame path/to/file


Cancelling changes
------------------

.. index::
  pair: Git; revert
  pair: Git; reset

If you want to cancel changes before they have been pushed, the best option is
probably ``git reset``.

Revert the index and working directory to the last, penultimate, etc... commit
with commands like::

  git reset --hard HEAD^
  git reset --hard HEAD^^
  git reset --hard HEAD^^^

Use with care, **changes to the working directory are discarded**.

The Pro Git has a section with much more details about `git reset
<https://git-scm.com/book/en/v2/Git-Tools-Reset-Demystified>`_.

If you want to cancel changes after they have been pushed, the best option is
probably ``git revert``. See the `documentation about git revert
<https://git-scm.com/docs/git-revert>`_.


.. _git_maintain_work_commit_diff:

Maintaining a difference between working and committed trees
------------------------------------------------------------

.. index::
  pair: Git; filter
  pair: Git; smudge filters
  pair: Git; clean filters
  pair: Git; .gitignore
  pair: Git; .git/info/exclude
  single: sed
  single: chmod
  single: gitk
  triple: Sphinx; Makefile; default target

In some cases, you want a particular file content in your working tree, that
you don't want to commit.

For example, this page you are currently reading is part of a `Sphinx
<http://www.sphinx-doc.org/en/master>`_ project. The page you're reading is the
result of Sphinx processing some source files and generating HTML output. On
project creation, Sphinx writes a `Makefile
<http://www.cs.colby.edu/maxwell/courses/tutorials/maketutor/>`_ and you just
have to issue a ``make html`` command to generate the HTML output. The ``html``
argument is mandatory because the Makefile is so that ``make`` (without
argument) does not generate the HTML output (it just outputs a help message).

For some reasons, I want to be able to generate the HTML output with ``make``
(without argument). One way to achieve that is to add those 2
lines somewhere in the file (the leading blank in the second line is actually a
tabulation character)::

  html: Makefile
  	@$(SPHINXBUILD) -M html "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

(You can :download:`download the whole file
<download/sphinx_makefile_with_html_as_default/Makefile>`.)

I think this change could surprise Sphinx users accustomed to the usual
behaviour of the Sphinx Makefile, so I prefer to commit the file with the
change commented out::

  # html: Makefile
  # 	@$(SPHINXBUILD) -M html "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

A Git smudge / clean filter makes that possible. Just create a
``.gitattributes`` file with the following line, which indicates that file
Makefile is to be filtered on checkout and on staging using (respectively) a
smudge and a clean filter named "html_as_default_target"::

  Makefile filter=html_as_default_target

There's no point committing the ``.gitattributes`` in such a case, so I added
it to the `.gitignore file
<https://www.atlassian.com/git/tutorials/saving-changes/gitignore>`_::

  echo .gitattributes>>.gitignore

Another option is to add it to the ``.git/info/exclude`` file. It applies only
to your local copy of the repository (unlike ``.gitignore`` which applies to
every clone of the repository).

The last step is to define the smudge and clean filters. The filters are
commands (typically involving the `sed
<https://www.gnu.org/software/sed/manual/sed.html>`_ program) given as local
configuration directives::

  git config --local filter.html_as_default_target.smudge 'sed "s/^# *\(.*html[ :].*\)$/\1/"'
  git config --local filter.html_as_default_target.clean 'sed "s/^\(.*html[ :].*\)$/# \1/"'

The smudge filter uncomments the lines containing "html " or "html:" and the
clean filter comments out those lines. They're visible in the ``.git/config``
file.

Note that the filters can be defined in external scripts. The clean filter
above could be a file containing:

| #!/bin/sh
|
| sed \"s/^\(.*html[ :].*\)$/# \1/\" $1

Assuming that this file is named ``clean_filter`` is located in a subdirectory
called ``filter`` of the working directory, the
``git config --local filter.html_as_default_target.clean`` should be (note the
``%f``)::

  git config --local filter.html_as_default_target.clean 'filter/clean_filter %f'

Of course, the script must be executable::

  chmod +x filter/clean_filter

One more thing that I've learned while working on a clean filter is that the
``sed`` program accepts multiple substitution commands, separated with
semicolons. It can be very useful when you need to clean multiple lines in a
file. Be careful, in some cases you may perform two substitutions at places
where you want only one. Try for example::

  printf "one\ntwo\nthree\n" | sed "s/one/two/; s/two/three/;"

I'm not sure what the most practical way to validate a clean filter is, but
`gitk <https://git-scm.com/docs/gitk>`_ can come in handy here. Commit, browse
the commit with gitk and check that the clean filter has caused the expected
changes. If not, fix the clean filter and amend the commit.

On a `Debian GNU/Linux <https://www.debian.org>`_ system, install gitk (**as
root**) with::

  apt-get install gitk


Resetting the commit and author dates
-------------------------------------

.. index::
  pair: Git; log
  pair: Git; rebase
  pair: Git; commit

Two dates are associated with a given commit: `the author date and the commit
date  <https://stackoverflow.com/a/11857467>`_.

One way to show both dates is to use ``git log`` with option
``--pretty=fuller``::

  git log --pretty=fuller

If for any reason you want to reset those dates to the current date for all the
commits (well, except the initial commit) of the current branch, you can do it
with::

  git rebase <commit_hash_of_the_initial_commit> \
      --exec 'git commit --amend --date="now" --no-edit --allow-empty'

You may want to add the ``--update-refs`` option to preserve the branching
structure::

  git rebase <commit_hash_of_the_initial_commit> \
      --exec 'git commit --amend --date="now" --no-edit --allow-empty' \
      --update-refs

If you also want to reset the dates of the initial commit, you can check it out
and do::

  git commit --amend --date="now" --no-edit --allow-empty

But then you will have to rebase your working branch on the new initial commit.


Creating an archive of the latest commit (without any history)
--------------------------------------------------------------

.. index::
  pair: Git; archive

The following commands create archives of the working directory in "tar" and
"zip" formats::

  git archive -o latest.tar HEAD
  git archive -o latest.zip HEAD


Cleaning a working directory
----------------------------

.. index::
  pair: Git; clean
  pair: Git; reset

The ``git clean -fdx`` deletes all untracked file (including ignored files).
**Use with great care !** You can do a dry run with ``git clean -ndx``.

If you also want to reset the changes made to tracked files and in staging
area, add a ``git reset --hard`` command::

  git reset --hard
  git clean -fdx

Again, **use with care!**


Scripting
---------

.. index::
  pair: Git; plumbing
  pair: Git; porcelain
  pair: Git; status
  pair: Git; symbolic-ref
  pair: Git; rev-parse
  pair: Git; for-each-ref
  pair: Git; diff-index
  pair: Git; diff-tree
  pair: Git; show-ref
  pair: Git; merge-base

It is sometimes needed to automate a sequence of Git commands and write a
script (a `shell script <https://en.wikipedia.org/wiki/Shell_script>`_ for
example). Scripting makes it possible to define :ref:`hooks <hooks>`.

`Git commands are divided into two categories
<https://stackoverflow.com/a/39848551>`_:

* Plumbing commands,

* Porcelain commands.

Porcelain commands should be avoided in scripts. They are meant to be used by
end-users (i.e. human beings, not programs) and produce a user-friendly output
which may not be stable. And output format stability is highly desirable for
commands used in scripts.

Plumbing commands provide stable, parser-friendly output and must be preferred
over porcelain commands in scripts.

As things are never as simple as they seem, some porcelain commands are
considered plumbing commands when used with the ``--porcelain`` option. ``git
status`` is an example of that::

  git status --porcelain

Here are a few Git commands that are useful for scripting::

  git symbolic-ref --short HEAD             # Outputs the checked out branch.
  git rev-parse --abbrev-ref HEAD           # Same output (but listed as
                                            # porcelain).
  git branch --show-current                 # Same output (but with Git 2.22 or
                                            # newer).

  git for-each-ref \                        # Lists the local branches.
      --format='%(refname:short)' \
      refs/heads/
  git rev-parse --abbrev-ref --branches     # Same output (but listed as
                                            # porcelain).

  git diff-index --quiet HEAD               # Does not output anything.
                                            # Terminates with exit status 0
                                            # when working tree is clean (but
                                            # possibly with untracked files),
                                            # with non zero exit status
                                            # otherwise.

  git diff-tree --name-only -r HEAD         # Lists the files changed in the
                                            # last commit. Use option
                                            # ``--no-commit-id`` to suppress
                                            # the first line (commit hash).

  git status --porcelain                    # Outputs nothing if the working
                                            # directory is clean (and without
                                            # any untracked files), outputs
                                            # something if the working
                                            # directory is not clean and/or has
                                            # untracked files.

  git show-ref --heads branch_name          # Provides the commit hash of the
                                            # head commit of branch
                                            # "branch_name".
  git show-ref --heads --abbrev branch_name # Similar, but provides short
                                            # commit hash (7 first characters
                                            # of commit hash).

  git merge-base --is-ancestor hash1 hash2  # Does not output anything.
                                            # Terminates with exit status 0
                                            # when commit with hash "hash1" is
                                            # an ancestor of commit with hash
                                            # "hash2" (and thus a fast forward
                                            # merge is possible from "hash1" to
                                            # "hash2"), with non zero exit
                                            # status otherwise.


.. _hooks:

Hooks
-----

.. index::
  pair: Git; hooks
  single: symbolic link
  single: ln
  single: chmod
  pair: Git; .git/hooks

Assuming that:

* You have a script "script-name" meant to be used as, say, a post-commit hook,

* This script is located at the top level of the working tree,

* The repository is in the standard ``.git`` subdirectory,

* The current working directory is the top level of the working tree,

you can install the hook with::

  ln -s ../../script-name .git/hooks/post-commit # Creates a symbolic link in
                                                 # .git/hooks.

Of course the script must be executable::

  chmod +x script-name

The `Git hooks section of the Pro Git book
<https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks>`_ lists the possible
hooks.

One difficulty with Git hooks is that when the hook of a repository operates on
another Git repository, the ``-C`` and ``--git-dir`` options may not be
respected. One solution can be to omit those options and to set environment
variables instead::

  export GIT_WORK_TREE=...
  export GIT_DIR=...

Also the GIT_INDEX_FILE environment variable must probably be unset::

  unset GIT_INDEX_FILE

More details can be found at those locations:

* https://stackoverflow.com/questions/7645480/why-doesnt-setting-git-work-tree-work-in-a-post-commit-hook

* https://longair.net/blog/2011/04/09/missing-git-hooks-documentation/


Submodules
----------

.. index::
  pair: Git; submodule
  pair: Git; config

You can add a repository as a submodule to your repository with a command
like::

  git submodule add submodule_repository_url subdirectory

You may want to specify which branch to track::

  git config -f .gitmodules submodule.<submodule_name>.branch <branch_name>

Update the submodules with::

  git submodule init
  git submodule update --remote

After cloning a repository with submodules, you also have to run
``git submodule init`` and ``git submodule update --remote``.


Other resources
---------------

* `Git documentation <https://git-scm.com/docs>`_
* `Pro Git book <https://git-scm.com/book/en/v2>`_
* `Git cheat sheet <https://www.git-tower.com/blog/git-cheat-sheet>`_
* `How to write a Git commit message <https://chris.beams.io/posts/git-commit>`_
* `A Git branching model <https://nvie.com/posts/a-successful-git-branching-model>`_
* `How to fix your Git branches after a rebase <https://www.viget.com/articles/how-to-fix-your-git-branches-after-a-rebase>`_
* `Getting solid at Git rebase vs. merge <https://delicious-insights.com/en/posts/getting-solid-at-git-rebase-vs-merge>`_
* `Working with stacked branches in Git is easier with --update-refs <https://andrewlock.net/working-with-stacked-branches-in-git-is-easier-with-update-refs>`_
* `git fixup: --amend for older commits <https://blog.filippo.io/git-fixup-amending-an-older-commit>`_
* `Git: To squash or not to squash? <https://jamescooke.info/git-to-squash-or-not-to-squash.html>`_
* `Git Submodules <https://blog.github.com/2016-02-01-working-with-submodules>`_
* `Git submodule “Quick Start” guide <https://gabrielstaples.com/git-submodule-guide>`_
* `How To: Merge a Git submodule into its main repository <https://medium.com/walkme-engineering/how-to-merge-a-git-submodule-into-its-main-repository-d83a215a319c>`_
