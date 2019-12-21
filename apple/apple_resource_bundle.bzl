load(
    "@build_bazel_rules_apple//apple:resources.bzl",
    _apple_resource_bundle = "apple_resource_bundle",
)

def apple_resource_bundle(
        name,
        infoplists,
        **kwargs):
    # Remove DEVELOPMENT_LANGUAGE and PRODUCT_BUNDLE_IDENTIFIER variables
    # in the resource bundle's Info.plists so that it can be used with Bazel.
    #
    # https://github.com/bazelbuild/rules_apple/issues/679
    # https://github.com/bazelbuild/rules_apple/pull/680
    # https://github.com/bazelbuild/rules_apple/pull/681

    # For the simplicity of this patch, we only use a single Info.plist for
    # each resource bundle target now.
    if len(infoplists) > 1:
        fail("This only allows a single Info.plist. Merge your plists first " +
             "before passing them to this macro.")
    infoplist = infoplists[0]

    modified_infoplists = [paths.basename(infoplist) + "-modified"]

    native.genrule(
        name = "info_plist_modified",
        srcs = [infoplist],
        outs = modified_infoplists,
        message = "Removing unsupported variables in {}".format(infoplist),
        cmd = """
plutil -remove CFBundleDevelopmentRegion -o - $< | \
plutil -remove CFBundleIdentifier -o $@ -
""",
    )

    _apple_resource_bundle(
        name = name,
        infoplists = modified_infoplists,
        **kwargs
    )
