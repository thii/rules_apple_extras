# Extra Apple Rules for [Bazel](https://bazel.build)

This repository contains additional rules for [Bazel](https://bazel.build) that
can be used to build libraries for Apple platforms.

## Reference documentation

### `objc_library`

Produces a static library from the given Objective-C source files, with (kind
of) support for header maps.

In iOS development, conventionally, when depending on an Objective-C library,
you can import its public headers using the system include syntax (`#import
<MyLibrary/MyLibrary.h>`) regardless of their location on the file sytem.
However, in Bazel, you have to explicitly specify the location of the imported
headers from the relatively from the included directories (`#import
"external/MyLibrary/MyLibrary.h"`). This rule wraps the native `objc_library`
rule to add support for the conventional import syntax, so that you won't have
to patch your libraries to support building with Bazel.

## Quick setup

Add the following to your `WORKSPACE` file to add the external repositories,
replacing the commit hash in the `commit` attribute with the version of the
rules you wish to depend on:

```python
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

git_repository(
    name = "com_github_thii_rules_apple_extras",
    remote = "https://github.com/thii/rules_apple_extras.git",
    commit = "<latest commit hash here>",
)
```

## Examples

With a load statement at the top of your BUILD file, you can use this rule as
you would with the native `objc_library` rule.

```python
load("@com_github_thii_rules_apple_extras//apple:objc_library.bzl", "objc_library")

objc_library(
    name = "Lib",
    hdrs = [
        "Lib.h",
    ],
    srcs = glob([
        "**/*.m",
    ]),
)
```

Any target that depends on `Lib` will be able to import `Lib`'s public header
using `#import <Lib/Lib.h>` syntax.

## License

MIT
