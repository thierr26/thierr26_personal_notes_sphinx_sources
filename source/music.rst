Music
=====

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell


Introduction
------------

This page is where I note the commands I use to manipulate audio files (`WAV
files <https://en.wikipedia.org/wiki/WAV>`_ and `Ogg files
<https://en.wikipedia.org/wiki/Ogg>`_).


Ogg file decoding
-----------------

.. index::
  single: oggdec
  pair: Ogg; decoding

Decode an Ogg file to a WAV file with a command like::

  oggdec -o output.wav input.ogg

The ``oggdec`` command is provided by package ``vorbis-tools`` on a `Debian
GNU/Linux <https://www.debian.org>`_ system).


WAV files duration
------------------

.. index::
  single: SoX
  pair: WAV file; duration

SoX can show (among other things) the duration in seconds of WAV files::

  sox my_wav_file.wav -n stat 2>&1 |grep ^Length
  soxi my_wav_file.wav|grep ^Duration

You can specify multiple files (or use wildcards) in the ``sox`` command to get
the cumulative duration of the files::

  sox *.wav -n stat 2>&1 |grep ^Length

The ``sox`` and ``soxi`` commands are provided by package ``sox`` on a `Debian
GNU/Linux <https://www.debian.org>`_ system).


Burning WAV files to a CD-R
---------------------------

.. index::
  single: cdrskin
  single: CD-R
  pair: WAV file; burning

You can burn some WAV files to a blank CD with a command like::

  cdrskin -v -eject -audio -pad *.wav


Building audio files from a video
---------------------------------

.. index::
  single: Freebox
  single: unaccent
  single: tr
  single: SoX
  single: oggenc
  pair: Ogg; encoding
  single: vorbiscomment
  pair: WAV file; fading
  pair: apt-cache commands; policy

I once wanted to make audio files from a nice TV show that I had recorded
on the hard drive of my `Freebox <https://en.wikipedia.org/wiki/Freebox>`_
(`V5 generation <https://en.wikipedia.org/wiki/Freebox#V5_generation>`_).

The TV show was recorded to a `.ts file
<https://en.wikipedia.org/wiki/MPEG_transport_stream>`_ and could be downloaded
to the computer from ftp://hd1.freebox.fr.

I created the audio files with a shell script. The script is mostly a loop over
the lines of a `here-document <https://en.wikipedia.org/wiki/Here_document>`_.
There is one line in the here-document for each audio file that I wanted to
create. Each line provides the start time of the audio file in the .ts file,
the duration of the audio file and the title of the audio file.

The source code is provided below. The here-document contains two lines:

| 00:16:44 00:03:43 The mission (Ennio Morricone)
| 00:33:20 00:03:19 Cinema Paradiso (Andrea & Ennio Morricone)

This will cause the creation of two WAV files in the directory denoted by
script variable ``INTERMEDIATE_FILES_DIR``:

* ``01_-_the_mission__ennio_morricone_.wav``
* ``02_-_cinema_paradiso__andrea_and_ennio_morricone_.wav``

You will also get two Ogg files in the directory denoted by script variable
``OUTPUT_DIR``:

* ``01_-_the_mission__ennio_morricone_.ogg``
* ``02_-_cinema_paradiso__andrea_and_ennio_morricone_.ogg``

The WAV files are created from the .ts file using ``ffmpeg``, provided by
package ``ffmpeg`` on a Debian GNU/Linux system. I'm using the version from
:ref:`deb-multimedia <add_debmultimedia>`, which is newer than the one in the
Debian archive. If you are not sure which version you have installed, check
with::

  apt-cache policy ffmpeg

The output file names are built from the titles provided in the here-document,
but with a few changes:

1. Occurrences of ampersand are substituted with "and".
2. Accents, cedillas, tildes, etc... are removed using the ``unaccent`` command
   (provided by package ``unaccent`` on a Debian GNU/Linux system).
3. Uppercase characters are converted to lowercase.
4. Remaining characters that are not letters, digits or hyphen are substituted
   with underscores.

A triangular (i.e. linear) fade out is created at the end of each file using
SoX.

The output Ogg files are encoded with ``oggenc``. They contain some comments:

* "tracknumber" (2-digits track number)
* "title" (title as provided in the here-document)
* "artist" (provided by script variable ``ARTIST``)
* "album" (provided by script variable ``ALBUM``)

To list the comments of an Ogg file, use ``vorbiscomment -l``::

  vorbiscomment -l my_ogg_file.ogg

``oggenc`` and ``vorbiscomment`` are provided by package ``vorbis-tools`` on a
Debian GNU/Linux system.

And here is the source code::

  #!/bin/sh

  SOURCE_DIR=directory/of/ts/file;                     # Adapt to your needs.
  SOURCE_FILE=ts_file.ts;                              # Adapt to your needs.
  SOURCE_PATH="$SOURCE_DIR/$SOURCE_FILE";

  OUTPUT_DIR=output/directory;                         # Adapt to your needs.

  INTERMEDIATE_FILES_DIR=intermediate/files/directory; # Adapt to your needs.

  ARTIST="artist name";                                # Adapt to your needs.
  ALBUM="album name";                                  # Adapt to your needs.

  OGGEXT=.ogg;
  WAVEXT=.wav;

  TEMP_SUFF=_;

  mkdir -p "$OUTPUT_DIR";
  rm -rf "$OUTPUT_DIR"/*;

  mkdir -p "$INTERMEDIATE_FILES_DIR";
  rm "$INTERMEDIATE_FILES_DIR"/*;

  K=0;

  # Loop over the lines of the here-document below.
  while IFS= read -r LINE; do
      START_TIME=$(echo "$LINE"|sed "s/ .*$//");
      LINE=$(echo "$LINE"|sed "s/^[^ ]\+ //");
      DURATION=$(echo "$LINE"|sed "s/ .*$//");
      LINE=$(echo "$LINE"|sed "s/^[^ ]\+ //");

      TITLE=$(echo "$LINE");

      # Substitute occurrences of ampersand with "and".
      OUTPUT_PATH=$(echo "$TITLE"|sed "s/&/and/");

      # Remove accents, cedillas, tildes, etc...
      OUTPUT_PATH=$(echo "$OUTPUT_PATH"|unaccent UTF-8);

      # Convert uppercase characters to lowercase.
      OUTPUT_PATH=$(echo "$OUTPUT_PATH"|tr '[:upper:]' '[:lower:]');

      # Substitute characters that are not lowercase letters, digits or hyphen
      # with underscores.
      OUTPUT_PATH=$(echo -n "$OUTPUT_PATH"|tr -c "a-z0-9-" [_*]);

      # Prepend track number (2 digits).
      K=$((K + 1));
      K_STR=$(printf "%02d" $K);
      OUTPUT_PATH="${K_STR}_-_$OUTPUT_PATH";

      WAV_PATH="$INTERMEDIATE_FILES_DIR/$OUTPUT_PATH$WAVEXT";
      OUTPUT_PATH="$OUTPUT_DIR/$OUTPUT_PATH$OGGEXT";

      echo "Creating $OUTPUT_PATH";

      # Create a WAV file. The -nostdin option is needed to prevent ffmpeg from
      # "eating" parts of the here-document.
      ffmpeg -nostdin -loglevel quiet -ss "$START_TIME" -t "$DURATION" \
          -i "$SOURCE_PATH" -ar 44100 "$WAV_PATH";

      # Fade out the WAV file.
      mv "$WAV_PATH" "$WAV_PATH$TEMP_SUFF";
      sox "$WAV_PATH$TEMP_SUFF" "$WAV_PATH" fade t 0 -0 7;
      rm "$WAV_PATH$TEMP_SUFF";

      # Encode to Ogg format.
      oggenc -a "$ARTIST" -t "$TITLE" -l "$ALBUM" -c "tracknumber=$K_STR" \
          -o "$OUTPUT_PATH" "$WAV_PATH";
  done<<HEREDOC
  00:16:44 00:03:43 The mission (Ennio Morricone)
  00:33:20 00:03:19 Cinema Paradiso (Andrea & Ennio Morricone)
  HEREDOC
