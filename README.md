## Reproducing the issue

See: https://github.com/hedronvision/bazel-compile-commands-extractor/issues/201

This repository reproduces an issue where the bazel build succeeds but hedron_compile_commands fails.

There seems to be some sort of mismatch between the protobuf version hedron_compile_commands is finding.

To reproduce:

Build everything:

```
bazel build //...
```

Run the example binary:

```
bazel run //example
```

You should see the following output on success:

```
INFO: Running command line: bazel-bin/example/example
example_pb.foo: 5, .bar: bar
```

Now try to generate compile_commands.json:

```
bazel run //:refresh_compile_commands
```

I see it fail with the following errors:

```
INFO: Running command line: bazel-bin/refresh_compile_commands
>>> Automatically added entries to .git/info/exclude to gitignore generated output.
>>> Analyzing commands used in //...
>>> While locating the headers you use, we encountered a compiler warning or error.
    No need to worry; your code doesn't have to compile for this tool to work.
    However, we'll still print the errors and warnings in case they're helpful for you in fixing them.
    If the errors are about missing files that Bazel should generate:
        You might want to run a build of your code with --keep_going.
        That way, everything possible is generated, browsable and indexed for autocomplete.
    But, if you have *already* built your code successfully:
        Please make sure you're supplying this tool with the same flags you use to build.
        You can either use a refresh_compile_commands rule or the special -- syntax. Please see the README.
        [Supplying flags normally won't work. That just causes this tool to be built with those flags.]
    Continuing gracefully...
In file included from example/main.cc:1:
bazel-out/k8-opt/bin/example/proto/example.pb.h:15:2: error: "This file was generated by a newer version of protoc which is"
#error "This file was generated by a newer version of protoc which is"
 ^
bazel-out/k8-opt/bin/example/proto/example.pb.h:16:2: error: "incompatible with your Protocol Buffer headers. Please update"
#error "incompatible with your Protocol Buffer headers. Please update"
 ^
bazel-out/k8-opt/bin/example/proto/example.pb.h:17:2: error: "your headers."
#error "your headers."
 ^
3 errors generated.
>>> Finished extracting commands for //...
```

## Work-around script

Instead of invoking refresh_compile_commands with `bazel run`, use the workaround script as follows:

```bash
./refresh_compile_commands.sh
```

This script succeeds without any errors or warnings.
