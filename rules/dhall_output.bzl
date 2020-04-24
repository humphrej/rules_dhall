
"""A rule that processes dhall files and creates an output"""
def _dhall_output_impl(ctx):
  entrypoint = ctx.attr.entrypoint.files.to_list()[0]

  outputFile = entrypoint.basename[0:-6] + "." + ctx.attr._format
  
  inputs = []
  inputs.append(entrypoint)

  if ctx.attr.out != "":
    outputFile = ctx.attr.out

  output = ctx.actions.declare_file(outputFile)

  # Build command
  cmd = []
  cmd.append( ctx.attr._dhall_output.files_to_run.executable.path )
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
  for src in ctx.attr.srcs:
    file = src.files.to_list()[0]
    inputs.append(file)

  cmd.append( ctx.attr._dhall_command.files_to_run.executable.path )
  cmd.append( output.path )
  cmd.append( entrypoint.path )

  ctx.actions.run_shell(
    inputs = inputs,
    outputs = [ output ],
    progress_message = "Generating output into '%s'" % output.path,
    tools = [ ctx.attr._dhall_command.files_to_run, ctx.attr._dhall_output.files_to_run ],
    command = " ".join(cmd),
    env = {
        "XDG_CACHE_HOME": ".cache",
        "_DHALL_ARGS": " ".join(ctx.attr.args)
    }
  )
  return [ DefaultInfo(files = depset([ output ])) ]

dhall_yaml = rule(
    implementation = _dhall_output_impl,
    attrs = {
      "entrypoint": attr.label(mandatory = True, allow_single_file = True),
      "srcs": attr.label_list(allow_files = [".dhall"]),
      "deps": attr.label_list(),
      "data": attr.label_list(),
      "out": attr.string(mandatory = False),
      "verbose": attr.bool( default = False ), 
      "args": attr.string_list(mandatory = False),
      "_format": attr.string(default = "yaml"),
      "_dhall_command": attr.label(
            default = Label("//cmds:dhall-to-yaml"),
            executable = True,
            cfg = "host"
      ),
      "_dhall_output": attr.label(
            default = Label("//rules:dhall-output"),
            executable = True,
            cfg = "host"
      ),
    }
)

dhall_json = rule(
    implementation = _dhall_output_impl,
    attrs = {
      "entrypoint": attr.label(mandatory = True, allow_single_file = True),
      "srcs": attr.label_list(allow_files = [".dhall"]),
      "deps": attr.label_list(),
      "data": attr.label_list(),
      "out": attr.string(mandatory = False),
      "verbose": attr.bool( default = False ), 
      "args": attr.string_list(mandatory = False),
      "_format": attr.string(default = "json"),
      "_dhall_command": attr.label(
            default = Label("//cmds:dhall-to-json"),
            executable = True,
            cfg = "host"
      ),
      "_dhall_output": attr.label(
            default = Label("//rules:dhall-output"),
            executable = True,
            cfg = "host"
      ),
    }
)

