let b =
      ./b.dhall sha256:75347c5c14371ad782b2c82a299b5acc1dd9eb8606e6cb795e0cb5b80a7a4089

let c =
      ./c.dhall sha256:8a52bd15729dbf07418d99d6fbc3ff2a79f69cd3bb606c2a412c696f12a81b51

in  b ∧ c ∧ { a = "A" }
