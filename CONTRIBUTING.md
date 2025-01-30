# How to contribute

We definitely welcome your patches and contributions to gRPC!

If you are new to github, please start by reading [Pull Request
howto](https://help.github.com/articles/about-pull-requests/)

## Legal requirements

In order to protect both you and ourselves, you will need to sign the
[Contributor License
Agreement](https://identity.linuxfoundation.org/projects/cncf).

## Code style

We follow the [Effective
Dart](https://www.dartlang.org/guides/language/effective-dart/style) code style.
We rely on auto-formatting all whitespace -- this avoids having to discuss
formatting during reviews. To format your code, run `dartfmt` from the root, or
use the similar action in your [favorite Dart
editor](https://www.dartlang.org/tools).

All code must pass Dart analysis. If you are using an IDE or Dart-enabled editor
it should raise analysis issues as you edit; alternatively validate from the
Terminal:

```
dart analyze
```

All analysis warnings and errors must be fixed; hints should be considered.

## Running tests

```
dart test
```

gRPC-web tests require [`envoy`](
https://www.envoyproxy.io/docs/envoy/latest/start/start.html) binary to be
available in the PATH.

## Guidelines for Pull Requests

How to get your contributions merged smoothly and quickly.

- Create **small PRs** that are narrowly focused on **addressing a single
concern**.

- For speculative changes, consider opening an issue and discussing it first.

- Provide a good **PR description** as a record of **what** change is being made
and **why** it was made. Link to a github issue if it exists.

- Unless your PR is trivial, you should expect there will be review comments
that you'll need to address before merging. We expect you to be reasonably
responsive to those comments, otherwise the PR will be closed after 2-3 weeks of
inactivity.

- Keep your PR up to date with upstream/master (if there are merge conflicts, we
can't really merge your change).

- **All tests need to be passing** before your change can be merged. We
recommend you **run tests locally** before creating your PR to catch breakages
early on.

- Exceptions to the rules can be made if there's a compelling reason for doing
so.

## Updating protobuf definitions
Sometimes we might need to update the generated dart files from the protos included in `lib/src/protos`. To do this, run the script `tool/regenerate.sh` from the project root and it will update the generated dart files in `lib/src/generated`.
