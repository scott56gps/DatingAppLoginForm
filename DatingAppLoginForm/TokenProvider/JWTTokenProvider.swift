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
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: "com.example.DatingAppLoginForm" as CFString,
            kSecAttrAccount: "jwttoken" as CFString,
            kSecValueData: token
        ]
        
        let writeStatus = SecItemAdd(query as CFDictionary, nil)
        guard writeStatus == errSecSuccess else {
            throw TokenError.tokenWriteFailed
        }
    }
}
