#ifdef _WIN64

static void hypot() {
}

namespace std {
    static void _hypot() {
    }
}

#include <cmath>

#endif
