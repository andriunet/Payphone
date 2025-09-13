//
//  UserListView.swift
//  Payphone
//
//  Created by Andres Marin on 13/09/25.
//

import SwiftUI
import RealmSwift

struct UserListView: View {
    @ObservedResults(RUser.self, where: { $0.isDeleted == false },
                     sortDescriptor: SortDescriptor(keyPath: "name", ascending: true))
    
    private var users
    @StateObject var viewModel: UserListViewModel
    @State private var showingCreate = false
    @State private var error: AppError?

    init(viewModel: UserListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        List {
            ForEach(users) { user in
                NavigationLink(destination: viewModel.detail(for: user.id)) {
                    HStack(spacing: 12) {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 32))
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.username).font(.headline)
                            Text(user.name).font(.subheadline)
                            Text("\("phone".localized): \(user.phone)").font(.caption)
                            Text("\("email".localized): \(user.email)").font(.caption)
                            Text("\("city".localized): \(user.city)").font(.caption)
                        }
                    }
                }
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        do {
                            try viewModel.delete(id: user.id)
                        } catch {
                            self.error = (error as? AppError) ?? AppError.persistence(error.localizedDescription)
                        }
                    } label: {
                        Label("delete".localized, systemImage: "trash")
                    }
                }
            }
        }
        .navigationTitle("users".localized)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button { showingCreate = true } label: { Label("add".localized, systemImage: "plus") }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    Task {
                        await refresh()
                    }
                } label:
                {
                    Label("refresh".localized, systemImage: "arrow.clockwise")
                }
            }
        }
        .task { await refresh() }
        .sheet(isPresented: $showingCreate) { viewModel.create() }
        .alert(item: $error) { err in
            Alert(title: Text("error".localized), message: Text(err.localizedDescription), dismissButton: .default(Text("ok".localized)))
        }
    }

    @MainActor private func refresh() async {
        do {
            try await viewModel.sync()
        } catch {
            self.error = (error as? AppError) ?? AppError.network(error.localizedDescription)
        }
    }
}


