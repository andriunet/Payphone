//
//  UserCreateViewModel.swift
//  Payphone
//
//  Created by Andres Marin on 13/09/25.
//

import Foundation

final class UserCreateViewModel: ObservableObject {
    @Published var showCoordsAlert = false
    private let repository: UserRepositoryType
    private let location = LocationManager()

    var coordsString: String {
        if let c = location.lastLocation?.coordinate {
            return String(format: "lat: %.5f, lon: %.5f", c.latitude, c.longitude)
        }
        return "no_location".localized
    }

    init(repository: UserRepositoryType) {
        self.repository = repository
    }

    func requestLocation() {
        location.requestOnce()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) { // Delay esperando para recibir las coordenadas
            self.showCoordsAlert = true
        }
    }

    func create(name: String, email: String, phone: String) throws {
        let n = try Validators.nonEmpty(name, field: "name".localized)
        let e = try Validators.email(email)
        let p = try Validators.phone(phone)
        try repository.create(name: n, email: e, phone: p, coords: location.lastLocation?.coordinate)
    }
}
