# Revision history for dependent-sum-aeson-orphans

This project's release branch is `master`. This log is written from the perspective of the release branch: when changes hit `master`, they are considered released, and the date should reflect that release.

## 0.3.1.0

* Enable PolyKinds. This is necessary to allow DSums where the key and value range over types other than `*`.

## 0.3.0.0

* Update dependencies, taking into account the split of `some` from `depenedent-sum`

## 0.2.1.0

* Add ToJSON instance for Some f which encodes the same way that a value of type f a would. The FromJSON instances for these will typically be derived by template haskell. See the aeson-gadt-th package for how to do that.
