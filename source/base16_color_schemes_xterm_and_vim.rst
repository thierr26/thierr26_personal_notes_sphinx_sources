Base16 color schemes (xterm and Vim)
====================================

.. index::
  pair: Base16 color schemes; xterm
  pair: Base16 color schemes; Vim
  single: .Xresources

Base16 is a set of color schemes, available for various applications. I like
that it makes it possible to have the same color scheme in my terminals (`xterm
<https://en.wikipedia.org/wiki/Xterm>`_) and in `Vim
<https://en.wikipedia.org/wiki/Vim_(text_editor)>`_ and to switch color scheme
very easily (by issuing a single command in the terminal like
``base16_classic-dark``).

I just followed the instructions in Scott Pierce's
`Base16 Shell blog post <https://ddrscott.github.io/blog/2017/base16-shell>`_.

I also have this line in my ``~/.Xresources``:

  XTerm*termName: xterm-256color

Base16_pop and base16_pico are two of my favorite Base16 schemes.

You can see the list of the base16 schemes with this command::

  alias | grep "^alias base16_"|sed "s/=.\+$//"
