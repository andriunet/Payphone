//
//  UserFormView.swift
//  Payphone
//
//  Created by Andres Marin on 13/09/25.
//

import SwiftUI
import RealmSwift

struct AlertPayload: Identifiable {
    let id = UUID()
    let title: String
    let message: String
}

struct UserFormView: View {
    @StateObject var viewModel: UserCreateViewModel
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""

    @State private var activeAlert: AlertPayload?

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            Form {
                Section("required".localized) {
                    TextField("name".localized, text: $name)
                    TextField("email".localized, text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    TextField("phone".localized, text: $phone)
                        .keyboardType(.phonePad)
                }
                Section("location".localized) {
                    Button { viewModel.requestLocation() } label: {
                        Label("get_location".localized, systemImage: "location")
                    }
                }
            }
            .navigationTitle("new_user".localized)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("cancel".localized) { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("save".localized) { create() }
                }
            }

            .onReceive(viewModel.$showCoordsAlert) { show in
                if show {
                    activeAlert = AlertPayload(
                        title: "coordinates".localized,
                        message: viewModel.coordsString
                    )
                    viewModel.showCoordsAlert = false
                }
            }
            .alert(item: $activeAlert) { payload in
                Alert(
                    title: Text(payload.title),
                    message: Text(payload.message),
                    dismissButton: .default(Text("ok".localized))
                )
            }
        }
    }

    private func create() {
        do {
            try viewModel.create(name: name, email: email, phone: phone)
            dismiss()
        } catch {
            let message = (error as? AppError)?.localizedDescription ?? error.localizedDescription
            activeAlert = AlertPayload(title: "error".localized, message: message)
        }
    }
}
