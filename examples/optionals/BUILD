package(default_visibility = ["//visibility:public"])

load("//:defs.bzl", "dhall_macro", "dhall_yaml")

# This one uses no additional arguments
dhall_macro(
    name = "optionals",
    entrypoint = "optionals.dhall",
    tags = ["block-network"],
)

# This one suppresses empty items
dhall_yaml(
    name = "optionals_with_args",
    entrypoint = "optionals.dhall",
    out = "optionals_with_args.yaml",
    dhall_args = ["--omit-empty"],
    tags = ["block-network"],
)

# This one fixes the types to get the same outcome
dhall_macro(
    name = "optionals2",
    entrypoint = "optionals2.dhall",
    tags = ["block-network"],
)
