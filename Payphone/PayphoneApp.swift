//
//  PayphoneApp.swift
//  Payphone
//
//  Created by Andres Marin on 13/09/25.
//

import SwiftUI
import RealmSwift

@main
struct PayphoneApp: SwiftUI.App {
    @StateObject private var coordinator = AppCoordinator()

      init() {
          var config = Realm.Configuration(schemaVersion: 1)
          config.migrationBlock = { _, _ in }
          Realm.Configuration.defaultConfiguration = config
      }

      var body: some Scene {
          WindowGroup {
              coordinator.start()
          }
      }
}
