def dhall_compile(name,  input, type="json", srcs=[], visibility=None):
  """Compiles a dhall document to JSON or YAML"""

  if input.endswith(".dhall") == False:
      fail("input must have a .dhall extension")

  input_base = input[0:-6]

  if type not in ["json", "yaml"]:
      fail("dhall only supports json or yaml")

  output = input_base + "." + type
  base_command = "dhall-to-"  + type

  cmd = base_command + " --file $(location " + input + ") > $@"

  # create a list of input + srcs, removing duplicates so use a dict as a set
  dict = {k: "" for k in srcs}
  dict[input] = ""
  all_srcs = dict.keys()

  native.genrule(
    name = name,
    srcs = all_srcs,
    outs = [output],
    cmd = cmd,
    visibility = visibility,
  )

