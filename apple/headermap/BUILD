# Pulled from https://github.com/ob/rules_ios/tree/a86298de81efd92f9719ff8f9ff5f4ef4c1b0878/rules

HMAP_COPTS = [
    "-DHASH_FUNCTION=HASH_MUR",
    "-DHASH_USING_NO_STRICT_ALIASING",
    "-fno-strict-aliasing",
]

HMAP_VISIBILITY = ["//visibility:public"]

cc_binary(
    name = "hmaptool",
    srcs = [
        "hmap.c",
        "hmap.h",
        "hmapbuild.c",
        "uthash.h",
    ],
    copts = HMAP_COPTS,
    visibility = HMAP_VISIBILITY,
)

cc_binary(
    name = "hmapdump",
    srcs = [
        "hmap.c",
        "hmap.h",
        "hmapdump.c",
        "uthash.h",
    ],
    copts = HMAP_COPTS,
    visibility = HMAP_VISIBILITY,
)

cc_test(
    name = "hmaptest",
    srcs = [
        "hmap.c",
        "hmap.h",
        "hmaptest.c",
        "uthash.h",
    ],
    visibility = ["//visibility:private"],
)
