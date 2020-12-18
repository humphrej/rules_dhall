load("//rules:dhall_library.bzl", _dhall_library = "dhall_library", _dhall_library_docs = "dhall_library_docs")
load("//rules:dhall_freeze.bzl", _dhall_freeze = "dhall_freeze")
load("//rules:dhall_output.bzl", _dhall_json = "dhall_json", _dhall_yaml = "dhall_yaml")

dhall_library = _dhall_library
dhall_library_docs = _dhall_library_docs
dhall_yaml = _dhall_yaml
dhall_json = _dhall_json
dhall_freeze = _dhall_freeze

def dhall_macro(name, **kwargs):
    dhall_library_macro(name, **kwargs)
    dhall_json(name = name + "_json", **kwargs)
    dhall_yaml(name = name + "_yaml", **kwargs)

def dhall_library_macro(name, **kwargs):
    """Create dhall_library build with dhall_freeze run target
    """
    dhall_library(name = name, **kwargs)
    dhall_freeze(name = name + "_freeze", **kwargs)

def dhall_prelude(name, visibility = None, **kwargs):
    """Create prelude library
    """
    dhall_library(
        name = name,
        entrypoint = "@dhall-prelude//:Prelude/package.dhall",
        srcs = ["@dhall-prelude//:dhall-prelude"],
        visibility = visibility,
        tags = ["block-network"],
        **kwargs
    )
    dhall_library_docs(
        name = "%s_docs" % name,
        srcs = ["@dhall-prelude//:dhall-prelude"],
        visibility = visibility,
        tags = ["block-network"],
        **kwargs
    )

def dhall_k8s(name, version, visibility = None, **kwargs):
    """Create k8s package library for version
    """
    dhall_library(
        name = name,
        entrypoint = "@dhall-kubernetes//:%s/package.dhall" % version,
        srcs = ["@dhall-kubernetes//:k8s-dhall-%s" % version],
        visibility = visibility,
        tags = ["block-network"],
        **kwargs
    )
    dhall_library_docs(
        name = "%s_docs" % name,
        srcs = ["@dhall-kubernetes//:k8s-dhall-%s" % version],
        visibility = visibility,
        tags = ["block-network"],
        **kwargs
    )
