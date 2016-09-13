p3600
=====

It's a game.


Running
-------

The engine was originally going to be written from scratch, but then I
found [LÖVE](https://love2d.org).

Since LÖVE is exactly what the original engine was going to be, but in
C++, it is used instead of reinventing the wheel.


Building
--------

Remember to run `git submodule init`, `git submodule update`. :wink:

The makefile is written so that `make -j` is safe.

### Recommended Method
Run `make p3600.love`.

### If You Want A Directory Instead
Run `make`.

### If You Don't Want The Files Compiled (for development, etc.)
You can run `make LUAJIT=cp` to copy the lua files instead of compiling them.
Compiling the files is recommended because the output is smaller.

### If You're On Windows&trade;
Download a pre-built version from the
[releases](https://github.com/bcnjr5/p3600/releases) page.
Windows is not a valid development platform, so you will never have a
reason to build from source anyway.


NaQ (Never-asked Questions)
---------------------------

### What's With The Name?

Everything else was taken?
If someone thinks of a better name, let us know.

### When I run the executable version, all my saves are gone/different!

LÖVE uses a different save directory depending on whether or not it is fused.
The save files should always be compatible, unless you are using a different
version.
(The changelog will explicitly state if a version uses a different save format.)
