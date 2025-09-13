//
//  Mappers.swift
//  Payphone
//
//  Created by Andres Marin on 13/09/25.
//

import Foundation

extension RUser {
    static func from(_ dto: UserDTO) -> RUser {
        let r = RUser()
        r.id = dto.id
        r.name = dto.name
        r.username = dto.username
        r.email = dto.email
        r.phone = dto.phone
        r.city = dto.address.city
        r.isDeleted = false
        r.isLocal = false
        r.updatedAt = Date()
        return r
    }
}
