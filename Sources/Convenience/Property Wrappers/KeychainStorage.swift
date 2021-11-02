
import Foundation
import OSLog

private let log = Logger("keychain-property-wrapper")

/// Property wrapper for storing and retrieving values securely in the keychain.
@propertyWrapper
public struct KeychainStorage {

    private let key: String
    
    public init(key: String) {
        self.key = key
    }
    
    public init(wrappedValue: String, key: String) {
        self.init(key: key)
        self.wrappedValue = wrappedValue
    }
    
    public var wrappedValue: String? {
        get {
            do {
                return try Keychain.string(forKey: key)
            } catch {
                log.error("Failed to get keychain item: \(error.localizedDescription)")
                return nil
            }
        }
        set {
            do {
                try Keychain.setString(newValue, forKey: key)
            } catch {
                log.error("Failed to set keychain item: \(error.localizedDescription)")
            }
        }
    }
}
