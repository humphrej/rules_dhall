"""A rule that processes dhall files and creates a tarfile of binary encodings"""
def _dhall_library_impl(ctx):
  entrypoint = ctx.attr.entrypoint.files.to_list()[0]

  output = ctx.actions.declare_file(ctx.label.name + "_tar")

  inputs = []
  inputs.append(entrypoint)

  # Build command
  cmd = []
  cmd.append(ctx.attr._dhall_library.files_to_run.executable.path)
  if ctx.attr.verbose == True:
    cmd.append( "-v")

  # Add tar files to the command and to the inputs
  for dep in ctx.attr.deps:
    cmd.append( "-d " + dep.files.to_list()[0].path)
    inputs.append( dep.files.to_list()[0] )

  for data in ctx.attr.data:
    cmd.append( "-r " + data.files.to_list()[0].path + ":" + entrypoint.dirname)
    inputs.append( data.files.to_list()[0] )

  # add all sources to the inputs
  for file in ctx.files.srcs:
    inputs.append(file)

  cmd.append(ctx.attr._dhall.files_to_run.executable.path)
  cmd.append(output.path)
  cmd.append(entrypoint.path)

  ctx.actions.run_shell(
    inputs = inputs,
    outputs = [ output ],
    progress_message = "Generating dhall files into '%s'" % output.path,
    tools = [ ctx.attr._dhall.files_to_run, ctx.attr._dhall_library.files_to_run ],
    command = " ".join(cmd),
    mnemonic = "DhallCompile"
  )

  return [ DefaultInfo(files = depset([ output ])) ]

dhall_library = rule(
    implementation = _dhall_library_impl,
    attrs = {
      "entrypoint": attr.label(mandatory = True, allow_single_file = True),
      "srcs": attr.label_list(allow_files = [".dhall"]),
      "deps": attr.label_list(),
      "data": attr.label_list(),
      "verbose": attr.bool( default = False ), 
      "_dhall": attr.label(
            default = Label("//cmds:dhall"),
            executable = True,
            cfg = "host"
      ),
      "_dhall_library": attr.label(
            default = Label("//rules:dhall-library"),
            executable = True,
            cfg = "host"
      ),
    }
)



