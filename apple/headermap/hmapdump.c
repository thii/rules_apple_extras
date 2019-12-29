// Pulled from https://github.com/ob/rules_ios/tree/a86298de81efd92f9719ff8f9ff5f4ef4c1b0878/rules

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/errno.h>

#include "hmap.h"

int main(int ac, char** av) {
  if (ac < 2) {
    fprintf(stderr, "usage: hmapdump <file>\n");
    return 1;
  }

  HeaderMap* hmap = hmap_open(av[1], "r");
  if (!hmap) {
    fprintf(stderr, "hmap failed for '%s': %s\n", av[1], strerror(errno));
  }
  hmap_dump(hmap);
  hmap_close(hmap);
}
