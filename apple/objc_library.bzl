"""Produces a static library from the given Objective-C source files.  This is
a wrapper of the native objc_library rule that adds support for header maps."""

_GENDIR = "gen_include"

def _module_include_dir(module_name):
    return _GENDIR + "/" + module_name

def _default_includes(module_name):
    return [
        _GENDIR,
        _module_include_dir(module_name),
    ]

def _generated_header_path(module_name, hdr):
    basename = hdr.rpartition("/")[-1]
    return _module_include_dir(module_name) + "/" + basename

def objc_library(
        name,
        deps = [],
        srcs = [],
        data = [],
        hdrs = [],
        alwayslink = False,
        compatible_with = [],
        copts = [],
        defines = [],
        deprecation = None,
        distribs = [],
        enable_modules = False,
        exec_compatible_with = [],
        exec_properties = {},
        features = [],
        includes = [],
        licenses = [],
        module_map = None,
        module_name = None,
        non_arc_srcs = [],
        pch = None,
        runtime_deps = [],
        sdk_dylibs = [],
        sdk_frameworks = [],
        sdk_includes = [],
        tags = [],
        testonly = None,
        textual_hdrs = [],
        toolchains = [],
        visibility = None,
        weak_sdk_frameworks = []):
    module_name = module_name or name

    for hdr in hdrs:
        native.genrule(
            name = hdr + "_gen",
            srcs = [hdr],
            outs = [_generated_header_path(module_name, hdr)],
            cmd = """
            echo '#import "$(location %s)"' > $@
            """ % hdr
        )

    native.objc_library(
        name = name,
        deps = deps,
        srcs = srcs,
        data = data,
        hdrs = hdrs + [
            _generated_header_path(module_name, hdr)
            for hdr in hdrs
        ],
        alwayslink = alwayslink,
        compatible_with = compatible_with,
        copts = copts,
        defines = defines,
        distribs = distribs,
        enable_modules = enable_modules,
        exec_compatible_with = exec_compatible_with,
        features = features,
        includes = includes + _default_includes(module_name),
        licenses = licenses,
        module_map = module_map,
        module_name = module_name,
        non_arc_srcs = non_arc_srcs,
        pch = pch,
        runtime_deps = runtime_deps,
        sdk_dylibs = sdk_dylibs,
        sdk_frameworks = sdk_frameworks,
        sdk_includes = sdk_includes,
        tags = tags,
        testonly = testonly,
        textual_hdrs = textual_hdrs,
        toolchains = toolchains,
        visibility = visibility,
        weak_sdk_frameworks = weak_sdk_frameworks,
    )
