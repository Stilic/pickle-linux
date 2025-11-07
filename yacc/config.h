// __dead and __dead2 are absent in musl
#define __dead __attribute__((__no_return__))
// HAVE_PROGNAME: Absent in musl
#define HAVE_ASPRINTF
// HAVE_PLEDGE: Absent in musl
#define HAVE_REALLOCARRAY
#define HAVE_STRLCPY
