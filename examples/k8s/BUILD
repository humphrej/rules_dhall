package(default_visibility = ["//visibility:public"])

load("//:defs.bzl", "dhall_k8s", "dhall_macro", "dhall_prelude")

dhall_k8s(name = "k8s", version = "1.16")
dhall_prelude(name = "prelude")

dhall_macro(
    name = "ingress",
    entrypoint = "ingress.dhall",
    deps = [
        ":k8s",
        ":prelude",
    ],
    tags = ["block-network"],
)
