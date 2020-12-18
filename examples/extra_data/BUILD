package(default_visibility = ["//visibility:public"])

load("//:defs.bzl", "dhall_json", "dhall_library_macro", "dhall_macro", "dhall_yaml")

dhall_macro(
    name = "with_data",
    entrypoint = "with_data.dhall",
    data = [":extra.txt"],
    tags = ["block-network"],
)
