
import Security
import OSLog

private let log = Logger("Keychain")

/// Utility type for storing simple string values into the keychain for secure storage.
public class Keychain {
    
    private init() {}

    public enum Operation: String {
        case create
        case fetch
        case delete
    }
    
    public enum Error: Swift.Error {
        /// Failed to encode the provided value as UTF-8 string data
        case utf8EncodingFailure
        /// Failed to decode the key's data into a UTF-8 string
        case utf8DecodingFailure
        /// Failed to perform the specified operation on the keychain
        case keychainOperationFailure(operation: Operation, code: OSStatus)
        /// Failed due to a known errSecMissingEntitlement
        case keychainEntitlementBugSeeLogsForDetails
        /// No keychain item found for the specified key
        case notFound
    }
    
    public class func setString(_ value: String?, forKey key: String) throws {
        
        // Setting a keychain item where one exists will fail, so we must delete any that exists first
        try removeString(forKey: key)
        
        // Let a nil value mean "remove only", and bail here
        guard let value = value else { return }
        
        guard let data = value.data(using: .utf8) else { throw Error.utf8EncodingFailure }
        
        let itemQuery: [CFString:Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: key,
            kSecValueData: data
        ]
        
        let status = SecItemAdd(itemQuery as CFDictionary, nil)
        
        switch status {
        case errSecSuccess:
            break // No error
        case -34018:  // errSecMissingEntitlement
            log.error("""
                You're being bitten by an iOS Simulator / Xcode bug (error code \(status)).
                The workaround is to enable Keychain Sharing:")
                https://forums.developer.apple.com/thread/51071")
                """)
            throw Error.keychainEntitlementBugSeeLogsForDetails
        default:
            throw Error.keychainOperationFailure(operation: .create, code: status)
        }
    }
    
    public class func string(forKey key: String) throws -> String? {
        
        let query: [CFString:Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: key,
            kSecReturnData: true
        ]
        
        var cfTypeResult: CFTypeRef? = nil
        let status = SecItemCopyMatching(query as CFDictionary, &cfTypeResult)
        
        switch status {
        case errSecSuccess:
            if let tokenData = cfTypeResult as? Data,
               let token = String(data: tokenData, encoding: .utf8) {
                    return token as String
            } else {
                throw Error.utf8DecodingFailure
            }
        case errSecItemNotFound:
            return nil
        default:
            throw Error.keychainOperationFailure(operation: .fetch, code: status)
        }
    }
    
    public class func removeString(forKey key: String) throws {
        
        let query: [CFString:Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: key,
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        switch status {
        case errSecSuccess, errSecItemNotFound:
            break // Token successfully deleted or already gone
        default:
            throw Error.keychainOperationFailure(operation: .delete, code: status)
        }
    }
    
}

public extension Keychain {
    /// Namespace for domain-specific constant key names.
    /// Use extensions to populate this namespace with static `String` values.
    struct Key {
        private init() {}
    }
}
