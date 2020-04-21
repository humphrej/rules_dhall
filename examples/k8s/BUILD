package(default_visibility = ["//visibility:public"])

load("//:defs.bzl", "dhall_yaml")

dhall_yaml(
    name = "ingress_yaml",
    src = "ingress.dhall",
    deps = [
        "@dhall-kubernetes//:k8s_package_library",
        "@dhall-kubernetes//:k8s_prelude_library",
    ],
)
