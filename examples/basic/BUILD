package(default_visibility = ["//visibility:public"])

load("//tools/dhall:dhall.bzl", "dhall_compile")

dhall_compile(
    name = "addresses",
    type = "json",
    input  = "addresses.dhall",
)


dhall_compile(
    name = "instruments",
    type = "yaml",
    input  = "instruments.dhall",
    srcs = [
        "instruments.dhall",
        "banjo.dhall",
    ]
)


