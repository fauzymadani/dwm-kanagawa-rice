# xssstate version
VERSION = 1.1

# Customize below to fit your system

# paths
PREFIX = /usr/local
LIBDIR = ${PREFIX}/lib
MANPREFIX = ${PREFIX}/share/man

# includes and libs
INCS = -I. -I/usr/include
LIBS = -L${LIBDIR} -lc -lX11 -lXss

# flags
CPPFLAGS = -DVERSION=\"${VERSION}\"
CFLAGS = -g -std=c99 -pedantic -Wall -O0 ${INCS} ${CPPFLAGS}
LDFLAGS = -g ${LIBS}

# Solaris
#CFLAGS = -fast ${INCS} -DVERSION=\"${VERSION}\"
#LDFLAGS = ${LIBS}

# compiler and linker
CC = cc

