package(default_visibility = ["//visibility:public"])

load("//:defs.bzl", "dhall_yaml", "dhall_library", "k8s_dhall_library")

k8s_dhall_library(name = "k8s", version = "1.17")


dhall_yaml(
    name = "server_yaml",
    entrypoint = "server.dhall",
)

# This demonstrates that it is possible to reference the output of dhall_yaml
dhall_library(
    name = "configmap_library",
    entrypoint = "configmap.dhall",
    data = [ ":server_yaml" ],
    deps = [
        ":k8s_package",
        ":k8s_prelude",
    ],
)

# This demonstrates that it is possible to reference the output of dhall_yaml
dhall_yaml(
    name = "configmap_yaml",
    entrypoint = "configmap.dhall",
    data = [ ":server_yaml" ],
    deps = [
        ":k8s_package",
        ":k8s_prelude",
    ],
)
