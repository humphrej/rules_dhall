package(default_visibility = ["//visibility:public"])

load("//:defs.bzl", "dhall_yaml", "dhall_library")

dhall_yaml(
    name = "server_yaml",
    src = "server.dhall",
)

# This demonstrates that it is possible to reference the output of dhall_yaml
dhall_library(
    name = "configmap_library",
    entrypoint = "configmap.dhall",
    data = [ ":server_yaml" ],
    deps = [
        "@dhall-kubernetes//:k8s_package_library",
        "@dhall-kubernetes//:k8s_prelude_library",
    ],
)

# This demonstrates that it is possible to reference the output of dhall_yaml
dhall_yaml(
    name = "configmap_yaml",
    src = "configmap.dhall",
    data = [ ":server_yaml" ],
    deps = [
        "@dhall-kubernetes//:k8s_package_library",
        "@dhall-kubernetes//:k8s_prelude_library",
    ],
)
