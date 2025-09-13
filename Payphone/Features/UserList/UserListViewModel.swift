//
//  UserListViewModel.swift
//  Payphone
//
//  Created by Andres Marin on 13/09/25.
//

import Foundation
import SwiftUICore

final class UserListViewModel: ObservableObject {
    private let repository: UserRepositoryType
    private let coordinator = UserFlowCoordinator()

    init(repository: UserRepositoryType) { self.repository = repository }

    @MainActor func sync() async throws { try await repository.syncUsers() }

    func detail(for id: Int) -> some View { coordinator.detail(for: id) }
    func create() -> some View { coordinator.create() }

    func delete(id: Int) throws { try repository.deleteLogical(id: id) }
}
