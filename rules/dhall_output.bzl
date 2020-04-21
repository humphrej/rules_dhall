
"""A rule that processes dhall files and creates an output"""
def _dhall_output_impl(ctx):
  input = ctx.attr.src.files.to_list()[0]

  outputFile = input.basename[0:-6] + "." + ctx.attr._format
  if ctx.attr.out != "":
    outputFile = ctx.attr.out

  output = ctx.actions.declare_file(outputFile)

  # Build command
  cmd = []
  cmd.append( ctx.attr._dhall_output.files_to_run.executable.path )
  cmd.append( ctx.attr._dhall_command.files_to_run.executable.path )
  cmd.append( output.path )
  cmd.append( input.path )

  tars = []
  for dep in ctx.attr.deps:
    cmd.append( dep.files.to_list()[0].path )
    tars.append( dep.files.to_list()[0] )

  ctx.actions.run_shell(
    inputs = [input] + tars,
    outputs = [ output ],
    progress_message = "Generating output into '%s'" % output.path,
    tools = [ ctx.attr._dhall_command.files_to_run, ctx.attr._dhall_output.files_to_run ],
    command = " ".join(cmd),
    env = {
        "XDG_CACHE_HOME": ".cache"
    }
  )
  return [ DefaultInfo(files = depset([ output ])) ]

dhall_yaml = rule(
    implementation = _dhall_output_impl,
    attrs = {
      "src": attr.label(mandatory = True, allow_single_file = True),
      "deps": attr.label_list(),
      "out": attr.string(mandatory = False),
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
      "src": attr.label(mandatory = True, allow_single_file = True),
      "deps": attr.label_list(),
      "out": attr.string(mandatory = False),
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

