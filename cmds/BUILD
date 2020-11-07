package(default_visibility = ["//visibility:public"])

sh_binary(
    name = "dhall",
    srcs = ["dhall.sh"],
    data = [
        "@dhall_bin//:bin/dhall",
        "@dhall_bin_osx//:bin/dhall",
    ],
)

sh_binary(
    name = "dhall-to-yaml",
    srcs = ["dhall-to-yaml.sh"],
    data = [
        "@dhall_to_json_bin//:bin/dhall-to-yaml",
        "@dhall_to_json_bin_osx//:bin/dhall-to-yaml",
    ],
)

sh_binary(
    name = "dhall-to-json",
    srcs = ["dhall-to-json.sh"],
    data = [
        "@dhall_to_json_bin//:bin/dhall-to-json",
        "@dhall_to_json_bin_osx//:bin/dhall-to-json",
    ],
)

