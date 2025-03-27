//
//  TabbarViewModel.swift
//  UsersList
//
//  Created by Roman Golub on 25.03.2025.
//

import Foundation

class TabBarViewModel: ObservableObject {
    @Published var selectedTab: TabBarItem = .users
    
    var tabItems: [TabBarItem] {
        TabBarItem.allCases
    }
    
    func selectTab(_ tab: TabBarItem) {
        selectedTab = tab
    }
}
