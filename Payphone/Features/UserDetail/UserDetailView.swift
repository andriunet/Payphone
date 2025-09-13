//
//  UserDetailView.swift
//  Payphone
//
//  Created by Andres Marin on 13/09/25.
//
import SwiftUI
import RealmSwift

struct UserDetailView: View {
    @ObservedRealmObject var user: RUser
    @StateObject private var viewModel: UserDetailViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var name: String
    @State private var email: String
    @State private var error: AppError?

    init(viewModel: UserDetailViewModel, user: RUser) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _user = ObservedRealmObject(wrappedValue: user)
        _name = State(initialValue: user.name)
        _email = State(initialValue: user.email)
    }

    var body: some View {
        Form {
            HStack(spacing: 16) {
                Image(systemName: "person.circle.fill")
                    .resizable().frame(width: 72, height: 72)
                VStack(alignment: .leading) {
                    Text(user.username).font(.headline)
                    Text(user.city).font(.subheadline)
                }
            }
            Section("info".localized) {
                TextField("name".localized, text: $name)
                TextField("email".localized, text: $email)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            }
            Section("readonly".localized) {
                Text("\("phone".localized): \(user.phone)")
                Text("ID: \(user.id)")
            }
        }
        .navigationTitle("detail".localized)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("save".localized) {
                    do {
                        try viewModel.save(name: name, email: email)
                        dismiss()
                    } catch {
                        self.error = (error as? AppError)
                            ?? .validation(error.localizedDescription)
                    }
                }
            }
        }
        .alert(item: $error) { err in
            Alert(title: Text("error".localized),
                  message: Text(err.localizedDescription),
                  dismissButton: .default(Text("ok".localized)))
        }
    }
}
