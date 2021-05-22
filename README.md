[![Unilicense](https://img.shields.io/badge/license-Unilicense-brightgreen)](https://unlicense.org)
[![Swift 5.4](https://img.shields.io/badge/Swift-5.4-blue)](https://swift.org)

# Convenience

This is a little holding place for common tools and conveniences that I like to use in my personal projects.

If anyone ever finds and uses this, I'd love to hear any feedback.

### Contents:

* `Keychain`: A simplistic wrapper for storing single `String` values into the user's keychain. Uses the `kSecClassGenericPassword` item class.
* `KeychainStorage`: A property wrapper that uses the `Keychain` convenience to wrap properties that use the user's keychain for their storage.
* `ReadersWriterLocked`: A property wrapper for making values thread-safe for access using a queue-based readers-writer lock.
* `UserDefault`: A property wrapper that uses `UserDefaults` for storage. Requires that the property type is `Codable`.
* `Logger+Conveniences`: An extension on the `Logger` type from Apple's `OSLog` module to add some conveniences:
    * `init(category:)`, which uses the process name and bundle name for the logger's `subsystem`.
* `Int+Conveniences`: A few extensions to `Int` for consise creation of multiple values:
    * `of<Value>(_ value: @autoclosure () throws -> Value) rethrows -> [Value])`: fills an array with _self_ values by executing the provided closure _self_ times.
    * `times(_ execute: @autoclosure () throws -> Void) rethrows`: executes the provided closure _self_ times.
