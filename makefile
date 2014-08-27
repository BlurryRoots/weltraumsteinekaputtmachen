name = HeX

all: repack run

repack:
	rm -f $(name).love
	zip -9qr $(name).love gfx lib sfx src *.lua

run:
	love $(name).love
