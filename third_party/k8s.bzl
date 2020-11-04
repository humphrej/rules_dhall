def k8s_dhall_files(versions, **kwargs):
  """Create named package and prelude libraries
  """
  for version in versions:
    native.filegroup(
      name = "k8s-dhall-%s" % version,
      srcs = native.glob(["%s/**/*.dhall" % version]),
      **kwargs
    )
    #dhall_library(
    #  name = "%s_%s_package" % (name, version),
    #  entrypoint = "%s/package.dhall" % version,
    #  srcs = [":%s-%s" % (name, version)]
    #)
    #dhall_library(
    #  name = "%s_%s_prelude" % (name, version),
    #  entrypoint = "%s/Prelude.dhall" % version,
    #  srcs = [":%s-%s" % (name, version)]
    #)

