// This header is generated by zig from base64.zig
#include "base64.h"

#include <assert.h>
#include <string.h>

int main(int argc, char **argv) {
    const char *encoded = "YWxsIHlvdXIgYmFzZSBhcmUgYmVsb25nIHRvIHVz";
    char buf[200];

    size_t len = decode_base_64(buf, 200, encoded, strlen(encoded));
    buf[len] = 0;
    assert(strcmp(buf, "all your base are belong to us") == 0);

    return 0;
}
