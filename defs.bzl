load("//rules:dhall_library.bzl", _dhall_library="dhall_library")
load("//rules:dhall_output.bzl", _dhall_yaml="dhall_yaml", _dhall_json="dhall_json")

dhall_library = _dhall_library
dhall_yaml = _dhall_yaml
dhall_json = _dhall_json

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
    entrypoint = "@dhall-kubernetes//:%s/Prelude.dhall" % version,
    srcs = ["@dhall-kubernetes//:k8s-dhall-%s" % version],
    visibility = visibility
  )

