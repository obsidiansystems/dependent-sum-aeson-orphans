# Revision history for dependent-sum-aeson-orphans

This project's release branch is `master`. This log is written from the perspective of the release branch: when changes hit `master`, they are considered released, and the date should reflect that release.

## Unreleased

* Add ToJSON instance for Some f which encodes the same way that a value of type f a would. The FromJSON instances for these will typically be derived by template haskell. See the aeson-gadt-th package for how to do that.