"""Define groupings by version of the k8s package files"""
def k8s_dhall_files(versions, **kwargs):
  """Create named package filegroups"""
  for version in versions:
    native.filegroup(
      name = "k8s-dhall-%s" % version,
      srcs = native.glob(["%s/**/*.dhall" % version]),
      **kwargs
    )
