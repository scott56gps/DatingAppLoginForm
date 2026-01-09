//
//  File.swift
//  FormValidation
//
//  Created by Scott Nicholes on 12/11/25.
//
import Foundation

enum ValidationRule<Value> {
    case required
    case minLength(Int)
    case maxLength(Int)
    case email
    case custom(message: String, (Value) -> Bool)
    
    func validate(_ value: Value) -> ValidationError? {
        switch self {
        case .required:
            if let string = value as? String {
                return string
                    .trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? ValidationError(
                        message:"This field is required"
                    ) : nil
            }
            return nil
        case .minLength(let min):
            if let string = value as? String {
                return string.count < min ? ValidationError(
                    message: "Value must be at least \(min) characters long"
                ) : nil
            }
            return nil
        case .maxLength(let max):
            if let string = value as? String {
                return string.count > max ? ValidationError(
                    message: "Value must be at least \(max) characters long"
                ) : nil
            }
            return nil
        case .email:
            if let string = value as? String {
                // Simple regex for email validation
                let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
                let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
                return predicate
                    .evaluate(with: string) ? nil : ValidationError(message: "Not a valid email address")
            }
            return nil
        case let .custom(message, predicate):
            return predicate(value) ? nil : ValidationError(message: message)
        }
    }
}
