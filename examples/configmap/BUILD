package(default_visibility = ["//visibility:public"])

load("//:defs.bzl", "dhall_macro", "k8s_dhall_library")

k8s_dhall_library(name = "k8s", version = "1.17")

dhall_macro(
    name = "server",
    entrypoint = "server.dhall",
)

# This demonstrates that it is possible to reference the output of dhall_yaml
dhall_macro(
    name = "configmap",
    entrypoint = "configmap.dhall",
    data = [ ":server_yaml" ],
    deps = [
        ":k8s_package",
        ":k8s_prelude",
    ],
)
