//
//  UserDTO.swift
//  Payphone
//
//  Created by Andres Marin on 13/09/25.
//

import Foundation

struct UserDTO: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let address: AddressDTO
}

struct AddressDTO: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: GeoDTO
}

struct GeoDTO: Codable {
    let lat: String
    let lng: String
}
