//
//  Validators.swift
//  Payphone
//
//  Created by Andres Marin on 13/09/25.
//

import Foundation

struct Validators {
    static func nonEmpty(_ value: String, field: String) throws -> String {
        let v = value.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !v.isEmpty else { throw AppError.validation("\(field) \("empty".localized) ") }
        return v
    }

    static func email(_ value: String) throws -> String {
        let v = try nonEmpty(value, field: "email".localized)
        let regex = try! NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
        let range = NSRange(location: 0, length: v.utf16.count)
        guard regex.firstMatch(in: v, range: range) != nil else { throw AppError.validation("invalid_email".localized) }
        return v
    }

    static func phone(_ value: String) throws -> String {
        let v = try nonEmpty(value, field: "phone".localized)
        let digits = v.filter { $0.isNumber }
        guard digits.count >= 7 else { throw AppError.validation("invalid_phone".localized) }
        return v
    }
}

extension String {
    var localized: String { NSLocalizedString(self, comment: "") }
}
