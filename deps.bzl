
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def load_dhall_dependencies():

  http_archive(
      name = "dhall_bin",
      sha256 = "9fc42f2f537bf62fd5e3afc959ec176936be448afe1ed3d3121c0d3a45b730b2",
      urls = ["https://github.com/dhall-lang/dhall-haskell/releases/download/1.36.0/dhall-1.36.0-x86_64-linux.tar.bz2"],
      build_file_content = "exports_files(['bin/dhall'])"
  )

  http_archive(
      name = "dhall_bin_osx",
      sha256 = "266c257c75033fe86e3b801bcc23f61fb4aa0978c984cff010e40f8ca4509fe0",
      urls = ["https://github.com/dhall-lang/dhall-haskell/releases/download/1.36.0/dhall-1.36.0-x86_64-macos.tar.bz2"],
      build_file_content = "exports_files(['bin/dhall'])"
  )

  http_archive(
      name = "dhall_to_yaml_bin",
      sha256 = "a29e2546bb617a9645124816ee9441253285bf767a5c8a9b6e2753aaf03a892c",
      urls = ["https://github.com/dhall-lang/dhall-haskell/releases/download/1.36.0/dhall-yaml-1.2.3-x86_64-linux.tar.bz2"],
      build_file_content = "exports_files(['bin/dhall-to-yaml-ng'])"
  )

  http_archive(
      name = "dhall_to_yaml_bin_osx",
      sha256 = "549e072da32f063a49e98a613edd15098ada24f9e4152dd673f557fae1b9dfd9",
      urls = ["https://github.com/dhall-lang/dhall-haskell/releases/download/1.36.0/dhall-yaml-1.2.3-x86_64-macos.tar.bz2"],
      build_file_content = "exports_files(['bin/dhall-to-yaml-ng'])"
  )

  http_archive(
      name = "dhall_to_json_bin",
      sha256 = "ff44c38d6b3c0f38d6d3b66be5744a33f8ac9b7351f918895b1b7fcff7fc3e40",
      urls = ["https://github.com/dhall-lang/dhall-haskell/releases/download/1.36.0/dhall-json-1.7.3-x86_64-linux.tar.bz2"],
      build_file_content = "exports_files(['bin/dhall-to-json'])"
  )

  http_archive(
      name = "dhall_to_json_bin_osx",
      sha256 = "6aba3360d3aaa8beacca369ab19d209d7333b4203cc585a7208f8accbba6de5d",
      urls = ["https://github.com/dhall-lang/dhall-haskell/releases/download/1.36.0/dhall-json-1.7.3-x86_64-macos.tar.bz2"],
      build_file_content = "exports_files(['bin/dhall-to-json'])"
  )

def load_dhall_k8s_dependencies():
  http_archive(
      name = "dhall-kubernetes",
      sha256 = "370516b4e3424bb0a683f9e8e0a9fc5a058ae89568f2712b97ae07f3095d4e0d",
      url = "https://github.com/dhall-lang/dhall-kubernetes/archive/a4126b7f8f0c0935e4d86f0f596176c41efbe6fe.zip",
      strip_prefix = "dhall-kubernetes-a4126b7f8f0c0935e4d86f0f596176c41efbe6fe",
      build_file = "@dhall//:BUILD.dhall-kubernetes",
  )

