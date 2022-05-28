
import Foundation
import OSLog

private let log = Logger("user-default-wrapper")

/// Property wrapper for convenient storage of properties in `UserDefaults`.
/// The wrapped property type must be `Optional` and `Codable`.
/// To delete a user default, assign a value of `nil` to the property.
/// All values are encoded/decoded as JSON for storage in `UserDefaults`.
@propertyWrapper
public struct UserDefault<Value: Codable> {
    
    public let key: String
    public let defaults: UserDefaults
    public let defaultValue: Value?
    
    private let encoder = JSONEncoder.shared
    private let decoder = JSONDecoder.shared
    
    
    /// Initialize a property that uses UserDefaults
    /// - Parameters:
    ///   - key: The `UserDefaults` lookup/storage key. Consider defining a constant if you intend to access the same key from multiple properties.
    ///   - defaults: The `UserDefaults` object to use for storage. Defaults to `.standard`.
    ///   - defaultValue: The value to store (and return) for the specified `key` if the value is read and no value is set. Defaults to `nil`.
    public init(key: String, defaults: UserDefaults = .standard, defaultValue: Value? = nil) {
        self.key = key
        self.defaults = defaults
        self.defaultValue = defaultValue
    }

    public var wrappedValue: Value? {
        get { retrieveValue() }
        set { storeValue(newValue) }
    }
    
    private func retrieveValue() -> Value? {
        guard let valueData = defaults.data(forKey: key) else {
            if let defaultValue = defaultValue {
                storeValue(defaultValue)
                return defaultValue
            } else {
                return nil
            }
        }
        
        do {
            let value = try decoder.decode(Value.self, from: valueData)
            return value
        } catch {
            log.error("UserDefault storage error: could not decode existing data.\nReason: \(error.localizedDescription)")
            assertionFailure()
            return nil
        }
    }
    
    private func storeValue(_ newValue: Value?) {
        guard let newValue = newValue else {
            defaults.removeObject(forKey: key)
            return
        }
        
        do {
            let data = try encoder.encode(newValue)
            defaults.set(data, forKey: key)
        } catch {
            if let newValue = newValue as? CustomStringConvertible {
                log.error("UserDefault storage error, could not encode new value:  \(newValue.description).\nReason: \(error.localizedDescription)")
            } else {
                log.error("UserDefault storage error, could not encode new value of non-CustomStringConvertible type \(type(of: newValue))")
            }
            assertionFailure()
        }
    }
}

private extension JSONEncoder {
    static let shared = JSONEncoder()
}

private extension JSONDecoder {
    static let shared = JSONDecoder()
}

public extension UserDefault {
    /// Namespace for domain-specific constant key names.
    /// Use extensions to populate this namespace with static `String` values.
    struct Key {
        private init() {}
    }
}
