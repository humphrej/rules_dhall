let kubernetes =
      ./package.dhall sha256:d9eac5668d5ed9cb3364c0a39721d4694e4247dad16d8a82827e4619ee1d6188

let _configMap1 =
      kubernetes.ConfigMap::{
      , metadata = kubernetes.ObjectMeta::{ name = "my-configmap" }
      , data = Some
        [ { mapKey = "server.yaml", mapValue = ./server.yaml as Text } ]
      }

in  _configMap1
