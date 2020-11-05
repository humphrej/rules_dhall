def k8s_dhall_files(versions, **kwargs):
  """Create named package and prelude libraries
  """
  native.filegroup(
    name = "k8s-dhall-prelude",
    srcs = ["Prelude.dhall"],
    **kwargs
    )
  for version in versions:
    native.filegroup(
      name = "k8s-dhall-%s" % version,
      srcs = native.glob(["%s/**/*.dhall" % version]),
      **kwargs
    )
