//
//  AppCoordinator.swift
//  Payphone
//
//  Created by Andres Marin on 13/09/25.
//

import Foundation
import SwiftUICore

final class AppCoordinator: ObservableObject {
    func start() -> some View {
        let userFlow = UserFlowCoordinator()
        return userFlow.start()
    }
}


