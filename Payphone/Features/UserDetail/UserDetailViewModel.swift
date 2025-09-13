//
//  UserDetailViewModel.swift
//  Payphone
//
//  Created by Andres Marin on 13/09/25.
//

import Foundation

final class UserDetailViewModel: ObservableObject {
    private let repository: UserRepositoryType
    private let userId: Int
    var userObj: RUser?

    init(repository: UserRepositoryType, userId: Int) {
        self.repository = repository
        self.userId = userId
        self.userObj = repository.user(by: userId)
    }

    func save(name: String, email: String) throws {
        let validName = try Validators.nonEmpty(name, field: "name".localized)
        let validEmail = try Validators.email(email)
        try repository.update(id: userId, name: validName, email: validEmail)
    }
}
