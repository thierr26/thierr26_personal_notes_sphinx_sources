Base16 color schemes (xterm and Vim)
====================================

.. index::
  pair: Base16 color schemes; xterm
  pair: Base16 color schemes; Vim
  single: ~/.Xresources
  single: ln

Base16 is a set of color schemes, available for various applications. I like
that it makes it possible to have the same color scheme in my terminals (`xterm
<https://en.wikipedia.org/wiki/Xterm>`_) and in `Vim
<https://en.wikipedia.org/wiki/Vim_(text_editor)>`_ and to switch color scheme
very easily (by issuing a single command in the terminal like
``base16_classic-dark``).

I just followed the instructions in Scott Pierce's
`Base16 Shell blog post <https://ddrscott.github.io/blog/2017/base16-shell>`_.

I also have this line in my ``~/.Xresources``:

| XTerm*termName: xterm-256color

My favorite Base16 schemes are:

* base16_pico

* base16_atelier-forest

* base16_cupertino

* base16_pop

You can see the list of the base16 schemes with this command::

  alias | grep "^alias base16_"|sed "s/=.\+$//"|sed "s/^.\+ //"

The following command is useful to choose a scheme. It traverses the list of
schemes and switches every 3 seconds::

  for SCHEME in $(alias \
          | grep ^alias\ base16_|sed 's/=.\+$//'|sed "s/^.\+ //"|sed s/_/-/); \
          do \
      _base16 ~/.config/base16-shell/scripts/$SCHEME.sh ${SCHEME#base16-}; \
      echo $SCHEME|sed s/-/_/; \
      sleep 3; \
   done;

As far as base16-vim is concerned, if it's the only color plugin you want
installed and you don't use any plugin manager like `Pathogen
<https://github.com/tpope/vim-pathogen>`_ or `Vundle
<https://github.com/VundleVim/Vundle.vim>`_, you may install it with the
following commands::

  cd ~/.vim
  git clone https://github.com/chriskempson/base16-vim
  ln -s base16-vim/colors colors
