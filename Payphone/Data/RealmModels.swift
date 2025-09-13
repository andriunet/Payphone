//
//  RealmModels.swift
//  Payphone
//
//  Created by Andres Marin on 13/09/25.
//

import Foundation
import RealmSwift

final class RUser: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String = ""
    @Persisted var username: String = ""
    @Persisted var email: String = ""
    @Persisted var phone: String = ""
    @Persisted var city: String = ""
    @Persisted var isDeleted: Bool = false 
    @Persisted var isLocal: Bool = false   // Nos dice si el usuario es local o no
    @Persisted var updatedAt: Date = Date()
}
