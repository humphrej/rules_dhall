package(default_visibility = ["//visibility:public"])

load("//:defs.bzl", "dhall_library", "dhall_yaml", "dhall_json")

# This one uses no additional arguments
dhall_yaml(
    name = "optionals_yaml",
    src = "optionals.dhall",
)
# This one suppresses empty items
dhall_yaml(
    name = "optionals_with_args_yaml",
    src = "optionals.dhall",
    out = "optionals_with_args.yaml",
    args = [ "--omit-empty" ]
)
