//
//  UsersScreenView.swift
//  UsersList
//
//  Created by Roman Golub on 25.03.2025.
//

import SwiftUI

struct UsersScreenView: View {
    @ObservedObject var viewModel: UsersViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                SearchView(searchQuery: $viewModel.searchText, text: "Search users")
                    .padding(.horizontal)
                    .onTapGesture {
                        UIApplication.shared.hideKeyboard()
                    }
                
                if viewModel.filteredUsers.isEmpty && !viewModel.isLoading {
                    ZStack {
                        Text("No results found")
                            .font(.title2)
                            .foregroundStyle(.white.opacity(0.7))
                            .onTapGesture {
                                UIApplication.shared.hideKeyboard()
                            }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            ForEach(viewModel.filteredUsers) { user in
                                NavigationLink(destination: UserDetailsScreen(viewModel: viewModel, user: user)) {
                                    UserCellView(viewModel: viewModel, user: user)
                                        .onAppear {
                                            if user.id == viewModel.users.last?.id {
                                                viewModel.loadData()
                                            }
                                        }
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            if viewModel.isLoading && !viewModel.filteredUsers.isEmpty {
                                ProgressView()
                                    .scaleEffect(1.2)
                                    .padding()
                            }
                        }
                        .padding(.top, 8)
                    }
                }
            }
            .backgroundGradient()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Users")
                        .font(.title.bold())
                        .foregroundStyle(.colorText)
                        .padding(.leading, 12)
                }
            }
            .onReceive(viewModel.$error, perform: { error in
                if error != nil {
                    viewModel.showAlert.toggle()
                }
            })
            .alert(isPresented: $viewModel.showAlert, content: {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.error?.localizedDescription ?? ""))
            })
            .refreshable {
                viewModel.handleRefresh()
            }
        }
    }
}

#Preview {
    UsersScreenView(viewModel: UsersViewModel())
}
