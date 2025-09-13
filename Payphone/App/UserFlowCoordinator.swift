//
//  UserFlowCoordinator.swift
//  Payphone
//
//  Created by Andres Marin on 13/09/25.
//

import Foundation
import SwiftUI

final class UserFlowCoordinator: ObservableObject {
    private let repository = UserRepository()

    func start() -> some View {
        let vm = UserListViewModel(repository: repository)
        return NavigationView { UserListView(viewModel: vm) }
    }

    func detail(for userId: Int) -> some View {
        let vm = UserDetailViewModel(repository: repository, userId: userId)
        return UserDetailView(viewModel: vm, user: vm.userObj ?? RUser())
    }

    func create() -> some View {
        let vm = UserCreateViewModel(repository: repository)
        return UserFormView(viewModel: vm)
    }
}
