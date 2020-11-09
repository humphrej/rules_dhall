
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def load_dhall_dependencies():

  http_archive(
      name = "dhall_bin",
      sha256 = "f8312727bbd4af74d183efce2e22f7b7807246a600fcc85600945f4790e4294a",
      urls = ["https://github.com/dhall-lang/dhall-haskell/releases/download/1.31.1/dhall-1.31.1-x86_64-linux.tar.bz2"],
      build_file_content = "exports_files(['bin/dhall'])"
  )

  http_archive(
      name = "dhall_bin_osx",
      sha256 = "522fbfebfd2b3ae1d3f0a2837b3beb225ec0bc3224b4ea8189e67d9783852938",
      urls = ["https://github.com/dhall-lang/dhall-haskell/releases/download/1.31.1/dhall-1.31.1-x86_64-macos.tar.bz2"],
      build_file_content = "exports_files(['bin/dhall'])"
  )

  http_archive(
      name = "dhall_to_yaml_bin",
      sha256 = "04d95773f9e96340a29f2857a55fb718735b83596abacf1d7b9fa3f6004067cb",
      urls = ["https://github.com/dhall-lang/dhall-haskell/releases/download/1.31.1/dhall-yaml-1.0.3-x86_64-linux.tar.bz2"],
      build_file_content = "exports_files(['bin/dhall-to-yaml-ng'])"
  )

  http_archive(
      name = "dhall_to_yaml_bin_osx",
      sha256 = "ae98e2bd0378ba81a8213ecd479d62549667dd3518d6882a507e9c84d41be813",
      urls = ["https://github.com/dhall-lang/dhall-haskell/releases/download/1.31.1/dhall-yaml-1.0.3-x86_64-macos.tar.bz2"],
      build_file_content = "exports_files(['bin/dhall-to-yaml-ng'])"
  )

  http_archive(
      name = "dhall_to_json_bin",
      sha256 = "7ec6b54f70f077d8876bb40633905f2a0a2c69e83a3ce0bd3d9f7577e1210489",
      urls = ["https://github.com/dhall-lang/dhall-haskell/releases/download/1.31.1/dhall-json-1.6.3-x86_64-linux.tar.bz2"],
      build_file_content = "exports_files(['bin/dhall-to-json'])"
  )

  http_archive(
      name = "dhall_to_json_bin_osx",
      sha256 = "b26e5b384502fe056cfcebed382101b30a3b2cc9438d4d967a00f9612dd4fbb0",
      urls = ["https://github.com/dhall-lang/dhall-haskell/releases/download/1.31.1/dhall-json-1.6.3-x86_64-macos.tar.bz2"],
      build_file_content = "exports_files(['bin/dhall-to-json'])"
  )

def load_dhall_k8s_dependencies():
  http_archive(
      name = "dhall-kubernetes",
      sha256 = "0bc2b5d2735ca60ae26d388640a4790bd945abf326da52f7f28a66159e56220d",
      url = "https://github.com/dhall-lang/dhall-kubernetes/archive/v4.0.0.zip",
      strip_prefix = "dhall-kubernetes-4.0.0",
      build_file = "@dhall//:BUILD.dhall-kubernetes",
  )

