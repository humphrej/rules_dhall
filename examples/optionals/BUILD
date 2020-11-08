package(default_visibility = ["//visibility:public"])

load("//:defs.bzl", "dhall_library", "dhall_yaml", "dhall_json")

# This one uses no additional arguments
dhall_yaml(
    name = "optionals_yaml",
    entrypoint = "optionals.dhall",
)
# This one suppresses empty items
dhall_yaml(
    name = "optionals_with_args_yaml",
    entrypoint = "optionals.dhall",
    out = "optionals_with_args.yaml",
    dhall_args = [ "--omit-empty" ]
)
# This one fixes the types to get the same outcome
dhall_yaml(
    name = "optionals2_yaml",
    entrypoint = "optionals2.dhall"
)

