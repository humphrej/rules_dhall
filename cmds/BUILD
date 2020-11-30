package(default_visibility = ["//visibility:public"])

load("@bazel_skylib//rules:native_binary.bzl", "native_binary")

native_binary(
    name = "dhall",
    out = "dhall",
    src = select({
        "@bazel_tools//src/conditions:linux_x86_64": "@dhall_bin//:bin/dhall",
        "@bazel_tools//src/conditions:darwin": "@dhall_bin_osx//:bin/dhall",
    }),
)

native_binary(
    name = "dhall-to-yaml",
    out = "dhall-to-yaml",
    src = select({
        "@bazel_tools//src/conditions:linux_x86_64": "@dhall_to_json_bin//:bin/dhall-to-yaml",
        "@bazel_tools//src/conditions:darwin": "@dhall_to_json_bin_osx//:bin/dhall-to-yaml",
    }),
)

native_binary(
    name = "dhall-to-json",
    out = "dhall-to-json",
    src = select({
        "@bazel_tools//src/conditions:linux_x86_64": "@dhall_to_json_bin//:bin/dhall-to-json",
        "@bazel_tools//src/conditions:darwin": "@dhall_to_json_bin_osx//:bin/dhall-to-json",
    }),
)

native_binary(
    name = "dhall-docs",
    out = "dhall-docs",
    src = select({
        "@bazel_tools//src/conditions:linux_x86_64": "@dhall_docs_bin//:bin/dhall-docs",
        "@bazel_tools//src/conditions:darwin": "@dhall_docs_bin_osx//:bin/dhall-docs",
    }),
)
