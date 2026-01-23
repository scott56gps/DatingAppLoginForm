import Foundation
import Combine
import Security

final class JWTTokenProvider: TokenProvider {
    func getToken() throws -> Data? {
        let query: [CFString: AnyObject] = [
            kSecAttrService: "com.example.DatingAppLoginForm" as AnyObject,
            kSecAttrAccount: "jwttoken" as AnyObject,
            kSecClass: kSecClassGenericPassword,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnData: kCFBooleanTrue
        ]

        var result: CFTypeRef?
        let readStatus = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard readStatus != errSecItemNotFound else {
            return nil
        }
        
        guard readStatus == errSecSuccess, let token = result as? Data else {
            throw TokenError.tokenReadFailed
        }
        
        return token
    }
    
    func setToken(token: Data) throws {
        let baseQuery: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: "com.example.DatingAppLoginForm" as CFString,
            kSecAttrAccount: "jwttoken" as CFString
        ]
        let updateAttributes: [CFString: Any] = [
            kSecValueData: token
        ]
        
        // First, try to update
        let updateStatus = SecItemUpdate(
            baseQuery as CFDictionary,
            updateAttributes as CFDictionary)
        
        switch updateStatus {
        case errSecSuccess: return
        case errSecItemNotFound:
            var addQuery = baseQuery
            addQuery[kSecValueData] = token
            let writeStatus = SecItemAdd(addQuery as CFDictionary, nil)
            guard writeStatus == errSecSuccess else {
                throw TokenError.tokenWriteFailed
            }
        default:
            throw TokenError.tokenReadFailed
        }
    }
}
