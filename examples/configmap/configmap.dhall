let kubernetes =
      ./package.dhall sha256:ef3845f617b91eaea1b7abb5bd62aeebffd04bcc592d82b7bd6b39dda5e5d545

let _configMap1 =
      kubernetes.ConfigMap::{
      , metadata = kubernetes.ObjectMeta::{ name = Some "my-configmap" }
      , data = Some
        [ { mapKey = "server.yaml", mapValue = ./server.yaml as Text } ]
      }

in  _configMap1
