all:

CP     ?= cp
MKDIR  ?= mkdir -p
LUAJIT ?= luajit -O -bs
ZIP    ?= zip -9 -u -v

dirs  := $(patsubst src/%,p3600/%,$(shell find src -type d))
files := $(patsubst src/%,p3600/%,$(shell find src -name "*.lua"))

# Jumper lib
dirs += $(patsubst libs/Jumper/%,p3600/%,$(shell find libs/Jumper/jumper -type d))
files += $(patsubst libs/Jumper/%,p3600/%,$(shell find libs/Jumper/jumper -name "*.lua"))

p3600/%.lua: src/%.lua $(dirs)
	$(LUAJIT) $< $@

# Jumper lib
p3600/jumper/%.lua: libs/Jumper/jumper/%.lua $(dirs)
	$(LUAJIT) $< $@

p3600/conf.lua: src/conf.lua
	$(CP) src/conf.lua p3600/conf.lua

$(dirs):
	$(MKDIR) $@

all: $(files)

p3600.love: $(files)
	$(MAKE) -C p3600 -f ../Makefile ../p3600.love

../p3600.love:
	$(ZIP) ../p3600.love -r * -x .gitignore -x '*.md'

.PHONY: all
