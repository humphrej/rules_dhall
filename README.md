# rules_dhall
This repo contains experimental rules for [bazel](https://bazel.build/) to generate files
using [Dhall](https://dhall-lang.org).

The rules use the method described by [@Gabriel439](https://github.com/Gabriel439) in [this answer](https://stackoverflow.com/questions/61139099/how-can-i-access-the-output-of-a-bazel-rule-from-another-rule-without-using-a-re)
 on stack overflow.

rules_dhall fetches binary releases of dhall from github - see section [command targets](#command-targets).

## Rule reference
###dhall_library
This rule takes a dhall file and makes it available to other rules.  The output of the 
rule is a tar archive that contains 3 files:
* the binary encoded, alpha normalized dhall expression (.cache/dhall)
* the dhall source file (source.dhall)
* a placeholder that includes the sha256 hash (binary.dhall)
   
Attribute  | Description |
---------- |  ---- |
name       | __string; required.__ 
entrypoint | __label; required.__  This is name of the dhall file that contains the expression that is the entrypoint to the package.  Any dhall references from entrypoint _must_ include the sha256 hash.
srcs       | __List of labels; optional.__ List of source files that are referenced from *entrypoint*.
deps       | __List of labels; optional.__ List of dhall_library targets that this rule should depend on.
verbose    | __bool; optional.__  If True, will output verbose logging to the console.

See example [abcd]().

###dhall_output
   This rule runs a dhall output generator (currently only dhall-to-yaml).  The output of
   the rule is the YAML file.

Attribute | Description |
----------| -----------| 
src       | __label; required (only one file).__  Any dhall references from entrypoint _must_ include the sha256 hash.
deps      | __List of labels; optional.__ List of dhall_library targets that this rule depends on.
out       | __string; optional.__ Defaults to the src file prefix + ".yaml".

See example [abcd](https://github.com/humphrej/dhall-bazel/tree/master/examples/abcd)

## Command targets

To run dhall or dhall-to-yaml via bazel:
```shell script
bazel run //cmds:dhall -- —help
bazel run //cmds:dhall-to-yaml -- —help
``` 
## Usage with dhall-kubernetes

It is possible to use these rules in combination with [dhall-kubernetes](https://github.com/dhall-lang/dhall-kubernetes). See example [k8s](https://github.com/humphrej/dhall-bazel/tree/master/examples/k8s).

## Note on freezing dependencies
rules_dhall relies on the semantic integrity checking feature of dhall.  For this to work,
dependencies referenced in a dhall expression must include the sha256 hash. See "dhall freeze"
for details.

## Note on hashing
To find the hash for a given package/tar:
```shell script
$ bazel //rules:dhall-hash — <path to tarfile>
```
