//
//  TabbarModel.swift
//  UsersList
//
//  Created by Roman Golub on 25.03.2025.
//

import Foundation

enum TabBarItem: Int, CaseIterable, Identifiable {
    case users
    case favorites
    
    var id: Int { self.rawValue }
    
    var iconName: String {
        switch self {
        case .users: return Icons.userIcon
        case .favorites: return Icons.bookmarksIcon
        }
    }
    
    var title: String {
        switch self {
        case .users: return "Users"
        case .favorites: return "Favorites"
        }
    }
}
