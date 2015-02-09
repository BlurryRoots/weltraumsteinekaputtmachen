name = NoName

ifeq ($(shell uname), Darwin)
	love = /Applications/love.app/Contents/MacOS/love
else
	love = love
endif

all: repack run

repack:
	rm -f bin/$(name).love
	zip -9qr bin/$(name).love gfx lib sfx src *.lua

run:
	$(love) bin/$(name).love

export:
	cat bin/$(name).love
