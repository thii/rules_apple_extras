"""Produces a static library from the given Objective-C source files.  This is
a wrapper of the native objc_library rule that adds support for header maps."""

load("//apple/headermap:hmap.bzl", "headermap")

def objc_library(
        name,
        deps = [],
        hdrs = [],
        copts = [],
        module_name = None,
        **kwargs):
    headermap(
        name = name + ".public_hmap",
        namespace = module_name or name,
        hdrs = hdrs,
        hdr_providers = deps,
        flatten_headers = True,
    )

    deps = deps + [
        name + ".public_hmap",
    ]

    copts = copts + [
        "-I$(execpath {})".format(name + ".public_hmap"),
        "-I.",
    ]

    native.objc_library(
        name = name,
        deps = deps,
        hdrs = hdrs,
        copts = copts,
        module_name = module_name,
        **kwargs
    )
