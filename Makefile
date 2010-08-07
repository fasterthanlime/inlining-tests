.PHONY: all clean

all:
	rock -inline all.ooc -v

clean:
	rm -rf .libs rock_tmp all
