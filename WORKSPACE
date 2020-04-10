workspace(name = "dhall")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

DHALL_KUBERNETES_VERSION = "4.0.0"

http_archive(
    name = "dhall-kubernetes",
    sha256 = "0bc2b5d2735ca60ae26d388640a4790bd945abf326da52f7f28a66159e56220d",
    url = "https://github.com/dhall-lang/dhall-kubernetes/archive/v%s.zip" % DHALL_KUBERNETES_VERSION,
    strip_prefix = "dhall-kubernetes-4.0.0",
    build_file = "@//:BUILD.dhall-kubernetes",
)


