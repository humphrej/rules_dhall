package(default_visibility = ["//visibility:public"])

genrule(
    name = "special_ingress",
    srcs = ["ingress.dhall",
            "Prelude.dhall",
            "package.dhall",
    ],
    outs = ["ingress.yaml"],
    cmd = "dhall-to-yaml --file $(location ingress.dhall) > $@",
    visibility = [
        "//visibility:public"
    ]
)




