# BASH script and config collection

Convenient collection to unlock the power of your shell. Works in all UNIX environments, including cygwin. Conservative enhancement, does not disable any existing functionality.

## Components

- **Bash**: enables color, large history, git support. Adds bash aliases, most notable the `l` to run ls with human readable file sizes and sorted ascendingly according to last changes
- **Vim**: 2 spaces indent, UNIX file format, color scheme, line numbers, case-insensitive search, <F2> for "paste text" mode, spell checker EN, swap files in $HOME, encoding UTF-8, Ctrl+C for NerdTree integration (comment it in)
- **Htop**: color scheme, page layout, meter settings, delays
- **Git**: Bash integration, `git diff ...` uses vimdiff
- **R**: Rstudio CRAN mirror, loading colorout, setwidth, vimdiff by default. Learn about vimdiff here: http://goo.gl/7SH1I

## Installation

To install, follow these easy steps:

1. Install the package
```
cd                                           # change directory to $HOME
git clone git://github.com/amaunz/home-bin   # clone the repository
cd home-bin                                  # change directory
./_init.sh                                   # install - it is safe to answer always 'y'
```
Please answer all questions with `y`, accepting the proposed changes. The changes are easy to revert if needed. Log out and in again to see the effect.

2. Configure git to use vim for `git diff ...`
Adjust `~/.gitconfig` to use your name and email address for git commits:

```
[user]
  name = Firstname Lastname
  email = firstname@lastname.de
```

## See also
- [Improved Ubuntu Terminal](): Set up a decent terminal on UNIX and Windows (cygwin). This package contains many of the features listed there.
- [Using Vim on Linux](https://www.evernote.com/shard/s89/sh/d1b56aba-6424-4559-b137-6154797eb728/b30994c9b55a03b59a2dc60457b91c0b): Unlock the power of Vim, the best text editor. This package contains many of the features listed there.

## Author
Andreas Maunz <andreas@maunz.de>, 12/2012


