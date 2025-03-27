//
//  MainScreenView.swift
//  UsersList
//
//  Created by Roman Golub on 25.03.2025.
//

import SwiftUI

struct MainScreenView: View {
    @StateObject var tabBarViewModel = TabBarViewModel()
    @StateObject var usersViewModel = UsersViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                switch tabBarViewModel.selectedTab {
                case .users:
                    UsersScreenView(viewModel: usersViewModel)
                case .favorites:
                    FavoriteScreenView(viewModel: usersViewModel)
                    
                }
                CustomTabBarView(viewModel: tabBarViewModel)
                    .padding(.bottom, 16)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    MainScreenView()
}
