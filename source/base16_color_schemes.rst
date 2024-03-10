Base16 color schemes
====================

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell

.. index::
  pair: Base16 color schemes; xterm
  pair: Base16 color schemes; Vim
  pair: Base16 color schemes; tmux
  single: Tinted Theming


Introduction
------------

I spend a lot of my computer time in front of a `Debian GNU/Linux
<https://www.debian.org>`_ box in a :doc:`tmux <tmux>` session with multiple
windows and panes (opened in an `xterm
<https://en.wikipedia.org/wiki/Xterm>`_), editing text files with `Vim
<https://en.wikipedia.org/wiki/Vim_(text_editor)>`_ or just doing command line
work in `Bash <https://en.wikipedia.org/wiki/Bash_(Unix_shell)>`_.

I'm using the Base16 theming system and appreciate that it makes it possible to
keep tmux and all my panes (with or without Vim opened in them) synchronized
with regard to the colors. I just have to issue a single command (like
``base16_classic-dark``) in one of the panes to switch the color scheme
everywhere.


Cloning Base16 repositories locally
-----------------------------------

.. index::
  pair: Git; clone

Just issue some ``git clone`` commands (as a normal user) in specific
subdirectories of your home directory::

  cd ~/.config
  git clone https://github.com/tinted-theming/base16-shell.git
  cd ~/.vim
  git clone https://github.com/tinted-theming/base16-vim.git
  cd ~/.tmux/plugins
  git clone https://github.com/tinted-theming/base16-tmux.git


Configuration
-------------


Enable 256 colors in terminals
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index::
  single: ~/.Xresources

Make sure you have the following line in your ``~/.Xresources``:

| XTerm*termName: xterm-256color


Have the color scheme applied on Bash startup
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index::
  single: ~/.bashrc

You need to tweak your ``~/.bashrc`` file to have the color scheme applied on
Bash startup. I didn't exactly follow the recommendations in the `README of
base16-shell <https://github.com/tinted-theming/base16-shell>`_. Instead I
added the following snippet to my ``~/.bashrc``:

| BASE16_SHELL_PATH=$HOME/.config/base16-shell/
| unset BASE16_THEME
| ! shopt -q login_shell || [ -n "$TMUX" ] \
|     && [ -s "$BASE16_SHELL_PATH/profile_helper.sh" ] \
|     && BASE16_SHELL_SET_BACKGROUND=false \
|     && source "$BASE16_SHELL_PATH/profile_helper.sh"

It makes sure that the color scheme is applied only when you're in a terminal
or in a tmux session, not when you're in a login shell in a text console.

The ``BASE16_SHELL_SET_BACKGROUND=false`` causes the background color of the
color scheme to be ignored. Without that, I find that most of the dark schemes
have a background color that is not black enough. The downside is that the
light schemes are pretty much unusable, but I wouldn't use them anyway...


Have the color scheme applied in Vim
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index::
  single: ~/.vimrc
  single: ln

First I created the ``~/.vim/colors`` symbolic link with
``~/.vim/base16-vim/colors`` as the target::

  cd ~/.vim
  ln -s base16-vim/colors

Then I added the following snippet to my ``~/.vimrc``:

| if exists('$BASE16_THEME')
|             \ && (!exists('g:colors_name')
|             \ || g:colors_name != 'base16-$BASE16_THEME')
|
|     let base16colorspace=256
|     if !has("gui_running")
|         let base16_background_transparent=1
|     endif
|     colorscheme base16-$BASE16_THEME
|
| endif

This is what is recommended in the `README of base16-shell
<https://github.com/tinted-theming/base16-shell>`_, except for the
``base16_background_transparent=1`` part that I had to add for the same reason
as I added ``BASE16_SHELL_SET_BACKGROUND=false`` above. The
``!has("gui_running")`` condition ensures the the transparent background option
is applied only in "terminal" Vim and not in graphical Vim (gvim). In gvim, the
transparent background option leads to a white background.


Have the color scheme applied in tmux
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index::
  single: ~/.tmux.conf

The Base16 theming system seems to work well with the following lines at the
top of the ``~/.tmux/conf`` file:

| # Use a 256 color terminal.
| set -g default-terminal "tmux-256color"
|
| # Useful if using base16-shell.
| set -g allow-passthrough 1
|
| # Add base16-tmux plugin to the list of TPM (Tmux Plugin Manager) plugins.
| set -g @plugin 'tinted-theming/base16-tmux'


Choosing a color scheme
-----------------------

There are more than 260 Base16 color schemes, so you're spoilt for choice!

You can see the list of the base16 schemes with this command::

  alias | grep "^alias base16_"|sed "s/=.\+$//"|sed "s/^.\+ //"

The `Base16 Gallery <https://tinted-theming.github.io/base16-gallery>`_ helps
to make a choice.

Alternatively, you can cycle through all the schemes with the following
commands (3 seconds delay before switching to the next scheme)::

  ALL_SCHEMES=$(alias|grep "^alias base16_"|sed 's/^[^"]\+"\([^"]\+\)".*$/\1/')
  for S in $ALL_SCHEMES; do sleep 3; echo "$S"; set_theme "$S"; done

If you want to exclude the schemes with "-light" in their name, do::

  ALL_SCHEMES=$(alias|grep "^alias base16_"|sed 's/^[^"]\+"\([^"]\+\)".*$/\1/')
  ALL_NON_LIGHT_SCHEMES=$(echo $ALL_SCHEMES | tr " " "\n" | grep -v "\-light")
  for S in $ALL_NON_LIGHT_SCHEMES; do sleep 3; echo "$S"; set_theme "$S"; done

Finally, to cycle through my favorite dark schemes, use::

  for S in \
      3024 \
      atelier-plateau \
      atlas \
      brewer \
      circus \
      codeschool \
      darcula \
      darktooth \
      embers \
      everforest \
      grayscale-dark \
      irblack \
      kanagawa \
      ocean \
      papercolor-dark \
      paraiso \
      phd \
      pico \
      primer-dark-dimmed \
      sandcastle \
      solarflare \
      standardized-dark \
      summercamp \
      twilight \
      vulcan \
      ; do sleep 3; echo "$S"; set_theme "$S"; done
