//
//  AppError.swift
//  Payphone
//
//  Created by Andres Marin on 13/09/25.
//

import Foundation

enum AppError: LocalizedError, Identifiable {
    var id: String { localizedDescription }

    case network(String)
    case validation(String)
    case persistence(String)
    case location(String)

    var errorDescription: String? {
        switch self {
        case .network(let m): return m
        case .validation(let m): return m
        case .persistence(let m): return m
        case .location(let m): return m
        }
    }
}
