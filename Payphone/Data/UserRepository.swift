//
//  UserRepository.swift
//  Payphone
//
//  Created by Andres Marin on 13/09/25.
//
import Foundation
import RealmSwift
import CoreLocation

protocol UserRepositoryType {
    func syncUsers() async throws
    func users() -> Results<RUser>
    func user(by id: Int) -> RUser?
    func create(name: String, email: String, phone: String, coords: CLLocationCoordinate2D?) throws
    func update(id: Int, name: String, email: String) throws
    func deleteLogical(id: Int) throws
}

final class UserRepository: UserRepositoryType {
    private let api: APIClientType

    init(api: APIClientType = APIClient()) {
        self.api = api
    }

    private func openRealm() throws -> Realm { try Realm() }

    func syncUsers() async throws {
        let remote = try await api.fetchUsers()
        print("API \(remote.count) usuarios")

        try await MainActor.run {
            let realm = try Realm()
            try realm.write {
                let toRemove = realm.objects(RUser.self).where { $0.isLocal == false }
                realm.delete(toRemove)
                for dto in remote { realm.add(RUser.from(dto), update: .modified) }
            }
            let remotos = realm.objects(RUser.self).where { $0.isLocal == false }.count
            let locales = realm.objects(RUser.self).where { $0.isLocal == true }.count
            print("Realm remotos:", remotos)
            print("Locales:", locales)
        }
    }

    func users() -> Results<RUser> {
        let realm = try! openRealm()
        return realm.objects(RUser.self)
            .where { $0.isDeleted == false }
            .sorted(byKeyPath: "name", ascending: true)
    }

    func user(by id: Int) -> RUser? {
        let realm = try! openRealm()
        return realm.object(ofType: RUser.self, forPrimaryKey: id)
    }

    func create(name: String, email: String, phone: String, coords: CLLocationCoordinate2D?) throws {
        let realm = try openRealm()
        let nextId = (realm.objects(RUser.self).max(ofProperty: "id") as Int? ?? 0) + 1

        let r = RUser()
        r.id = nextId
        r.name = name
        r.email = email
        r.phone = phone
        r.username = name.replacingOccurrences(of: " ", with: "").lowercased()
        r.city = coords != nil ? "Lat: \(coords!.latitude), Lon: \(coords!.longitude)" : "Local"
        r.isLocal = true
        r.updatedAt = Date()

        try realm.write { realm.add(r, update: .modified) }
    }

    func update(id: Int, name: String, email: String) throws {
        let realm = try openRealm()
        guard let user = realm.object(ofType: RUser.self, forPrimaryKey: id) else {
            throw AppError.persistence("user_not_found".localized)
        }
        try realm.write {
            user.name = name
            user.email = email
            user.updatedAt = Date()
        }
    }

    func deleteLogical(id: Int) throws {
        let realm = try openRealm()
        guard let user = realm.object(ofType: RUser.self, forPrimaryKey: id) else { return }
        try realm.write { user.isDeleted = true }
    }
}
