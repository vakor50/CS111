CFLAGS = -Wall -g

# This is the tarball name.
DIST = lab3-design

# When adding .c files, append them to this list.
SRCS = main.c ospfsfix.c

# When adding .h files, append them to this list.
HDRS = ospfs.h ospfsfix.h

# When adding other files, append them to this list.
OTHERS = Makefile README.md tester

ospfsfixer: clean $(SRCS)
	@printf "\n* * * Making ospfsfixer * * *\n\n"
	gcc $(CFLAGS) -o ospfsfix $(SRCS)

dist: ospfsfixer clean
	@printf "\n* * * Making tarball * * *\n\n"
	rm -rf $(DIST)
	mkdir $(DIST)
	cp $(SRCS) $(HDRS) $(OTHERS) $(DIST)/
	tar cvf $(DIST).tar.gz $(DIST)

clean:
	@printf "\n* * * Cleaning directory * * *\n\n"
	rm -rf ospfsfix
	rm -rf $(DIST).tar.gz
	rm -rf $(DIST)

test: ospfsfixer
	@printf "\n* * * Testing * * *\n\n"
	./tester