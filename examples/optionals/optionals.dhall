let MyType =
      { x : Text
      , y : Optional Natural
      , z : List { mapKey : Text, mapValue : Text }
      }

let _mytype1
    : MyType
    = { x = "qwerty"
      , y = None Natural
      , z = [ { mapKey = "key1", mapValue = "val1" } ]
      }

let _mytype2
    : MyType
    = { x = "qwerty"
      , y = None Natural
      , z = [] : List { mapKey : Text, mapValue : Text }
      }

in  [ _mytype1, _mytype2 ]
