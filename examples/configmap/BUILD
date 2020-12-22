package(default_visibility = ["//visibility:public"])

load("//:defs.bzl", "dhall_k8s", "dhall_macro", "dhall_prelude")

dhall_k8s(name = "k8s", version = "1.17")
dhall_prelude(name = "prelude")

dhall_macro(
    name = "server",
    entrypoint = "server.dhall",
    tags = ["block-network"],
)

# This demonstrates that it is possible to reference the output of dhall_yaml
dhall_macro(
    name = "configmap",
    entrypoint = "configmap.dhall",
    data = [":server_yaml"],
    deps = [
        ":k8s",
        ":prelude",
    ],
    tags = ["block-network"],
)
