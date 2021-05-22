
import Foundation
import OSLog

private let log = Logger(subsystem: "\(ProcessInfo().processName)[\(Bundle.main.bundleIdentifier ?? "unknown bundle")]",
                         category: "user-default-wrapper")

/// Property wrapper for convenient storage of properties in UserDefaults.
/// The wrapped property type must be `Optional` and `Codable`.
/// To delete a user default, assign a value of `nil` to the property.
@propertyWrapper
public struct UserDefault<Value: Codable> {
    
    public let key: String
    public let defaults: UserDefaults
    
    private let encoder = PropertyListEncoder.shared
    private let decoder = PropertyListDecoder.shared
    
    public init(key: String, defaults: UserDefaults = .standard) {
        self.key = key
        self.defaults = defaults
    }

   public  var wrappedValue: Value? {
        get { retrieveValue() }
        set { storeValue(newValue) }
    }
    
    private func retrieveValue() -> Value? {
        guard let valueData = defaults.data(forKey: key) else {
            return nil
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
            log.error("UserDefault storage error, could not encode new value:  \(Mirror(reflecting:newValue)).\nReason: \(error.localizedDescription)")
            assertionFailure()
        }
    }
}

private extension PropertyListEncoder {
    static let shared = PropertyListEncoder()
}

private extension PropertyListDecoder {
    static let shared = PropertyListDecoder()
}

public extension UserDefault {
    /// Namespace for domain-specific constant key names.
    /// Use extensions to populate this namespace with static `String` values.
    struct Key {
        private init() {}
    }
}
