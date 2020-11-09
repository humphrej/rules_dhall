package(default_visibility = ["//visibility:public"])

load("//:defs.bzl", "dhall_macro", "k8s_dhall_library")

k8s_dhall_library(name = "k8s_1_16", version = "1.16")

dhall_macro(
    name = "ingress",
    entrypoint = "ingress.dhall",
    deps = [
        ":k8s_1_16_package",
        ":k8s_1_16_prelude",
    ],
)
