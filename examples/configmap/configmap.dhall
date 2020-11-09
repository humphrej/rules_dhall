let kubernetes =
      env:DHALLBAZEL_k8s_package sha256:ef3845f617b91eaea1b7abb5bd62aeebffd04bcc592d82b7bd6b39dda5e5d545

let _configMap1 =
      kubernetes.ConfigMap::{
      , metadata = kubernetes.ObjectMeta::{ name = Some "my-configmap" }
      , data = Some
        [ { mapKey = "server.yaml"
          , mapValue =
              ./server.yaml sha256:d5c136554820d32d20836b3346f7e39ef855b104925ecf27b81ac86b1e49378b as Text
          }
        ]
      }

in  _configMap1
