let MyType =
      { x : Text
      , y : Optional Natural
      , z : Optional (List { mapKey : Text, mapValue : Text })
      }

let _mytype1
    : MyType
    = { x = "qwerty"
      , y = None Natural
      , z = Some [ { mapKey = "key1", mapValue = "val1" } ]
      }

let _mytype2
    : MyType
    = { x = "qwerty"
      , y = None Natural
      , z = None (List { mapKey : Text, mapValue : Text })
      }

in  [ _mytype1, _mytype2 ]
