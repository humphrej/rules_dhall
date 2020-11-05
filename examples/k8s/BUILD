package(default_visibility = ["//visibility:public"])

load("//:defs.bzl", "dhall_yaml", "k8s_dhall_library")

k8s_dhall_library(name = "k8s_1.16", version = "1.16")

dhall_yaml(
    name = "ingress_yaml",
    entrypoint = "ingress.dhall",
    deps = [
        ":k8s_1.16_package",
        ":k8s_1.16_prelude",
    ],
)
