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
        "@dhall_to_yaml_bin//:bin/dhall-to-yaml-ng",
        "@dhall_to_yaml_bin_osx//:bin/dhall-to-yaml-ng",
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

