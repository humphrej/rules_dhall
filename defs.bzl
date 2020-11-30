load("//rules:dhall_library.bzl", _dhall_library="dhall_library", _dhall_library_docs="dhall_library_docs")
load("//rules:dhall_freeze.bzl", _dhall_freeze="dhall_freeze")
load("//rules:dhall_output.bzl", _dhall_yaml="dhall_yaml", _dhall_json="dhall_json")

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

def k8s_dhall_library(name, version, visibility=None, **kwargs):
  """Create named package and prelude libraries
  """
  dhall_library(
    name = "%s_package" % name,
    entrypoint = "@dhall-kubernetes//:%s/package.dhall" % version,
    srcs = ["@dhall-kubernetes//:k8s-dhall-%s" % version],
    visibility = visibility
  )
  dhall_library(
    name = "%s_prelude" % name,
    entrypoint = "@dhall-kubernetes//:Prelude.dhall",
    srcs = ["@dhall-kubernetes//:k8s-dhall-prelude"],
    visibility = visibility
  )
  dhall_library_docs(
    name = "%s_package_docs" % name,
    srcs = ["@dhall-kubernetes//:k8s-dhall-%s" % version],
    visibility = visibility
  )
