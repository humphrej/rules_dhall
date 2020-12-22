package(default_visibility = ["//visibility:public"])

load("//:defs.bzl", "dhall_json", "dhall_library_macro", "dhall_macro", "dhall_yaml")

dhall_macro(
    name = "a",
    entrypoint = "a.dhall",
    deps = [
        ":b",
        ":c",
    ],
    tags = ["block-network"],
)

dhall_library_macro(
    name = "b",
    entrypoint = "b.dhall",
    deps = [
        ":d",
    ],
    tags = ["block-network"],
)

dhall_library_macro(
    name = "c",
    entrypoint = "c.dhall",
    tags = ["block-network"],
)

dhall_library_macro(
    name = "d",
    entrypoint = "d.dhall",
    tags = ["block-network"],
)

# This one adds an additional yaml target useing an explicit output filename of ouch.yaml
dhall_yaml(
    name = "ouch_yaml",
    entrypoint = "a.dhall",
    out = "ouch.yaml",
    deps = [
        ":b",
        ":c",
    ],
    tags = ["block-network"],
)

## This one does not use any intermediate targets
# TODO:broken
#dhall_yaml(
#    name = "a_no_intermediates_yaml",
#    entrypoint = "a-direct.dhall",
#    out = "a_no_intermediates.yaml",
#    srcs = [ "b.dhall", "c.dhall", "d.dhall" ]
#)
