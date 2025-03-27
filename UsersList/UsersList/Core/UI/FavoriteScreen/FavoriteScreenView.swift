//
//  FavoriteScreenView.swift
//  UsersList
//
//  Created by Roman Golub on 25.03.2025.
//

import SwiftUI
import RealmSwift

struct FavoriteScreenView: View {
    @ObservedObject var viewModel: UsersViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                if viewModel.getFavorites().isEmpty {
                    ZStack {
                        Text("No favorites yet")
                            .font(.title2)
                            .foregroundStyle(.white.opacity(0.7))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .backgroundGradient()
                } else {
                    
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.favorites) { user in
                                NavigationLink(destination: UserDetailsScreen(viewModel: viewModel, user: user)) {
                                    UserCellView(viewModel: viewModel, user: user)
                                }
                                .id(user.id)
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.top, 10)
                    }
                }
            }
            .backgroundGradient()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Favorites")
                        .font(.title.bold())
                        .foregroundStyle(.colorText)
                        .padding(.leading, 12)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.updateFavorites()
            }
        }
    }
}

#Preview {
    FavoriteScreenView(viewModel: UsersViewModel())
}
