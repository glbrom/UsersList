//
//  UserViewModel.swift
//  UsersList
//
//  Created by Roman Golub on 25.03.2025.
//

import Foundation
import RealmSwift

class UsersViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var support: Support?
    @Published var favorites: [User] = []
    @Published var error: Error?
    @Published var searchText: String = ""
    @Published var isLoading = false
    @Published var showAlert = false
    
    private var storageService = UserStorageServiceRealm()
    private var page = 0
    private let BASE_URL = "https://reqres.in"
    
    init() {
        loadData()
    }
    
    var urlString: String {
        return  "\(BASE_URL)/api/users?page=\(page)"
    }
    
    var filteredUsers: [User] {
        if searchText.isEmpty {
            return users
        } else {
            return users.filter {
                $0.firstName.lowercased().hasPrefix(searchText.lowercased()) || $0.lastName.lowercased().hasPrefix(searchText.lowercased())
            }
        }
    }
    
    func toggleFavorite(user: User) {
        if isFavorite(user: user) {
            storageService.removeFavorite(userId: user.id)
        } else {
            storageService.addFavorite(user: user)
        }
        updateFavorites()
    }
    
    func updateFavorites() {
        favorites = storageService.getFavorites()
    }
    
    func isFavorite(user: User) -> Bool {
        storageService.isFavorite(userId: user.id)
    }
    
    func getFavorites() -> [User] {
        storageService.getFavorites()
    }
    
    func handleRefresh() {
        users.removeAll()
        page = 0
        loadData()
    }
}

extension UsersViewModel {
    @MainActor
    func fetchUsersAsync() async throws {
        do {
            isLoading = true
            defer { isLoading = false }
            page += 1
            print("Loading page \(page)")
            if page > 1 {
                print("Delay of 3 seconds..")
                try await Task.sleep(nanoseconds: 3_000_000_000)
            }
            guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
            let (data, response) = try await URLSession.shared.data(from: url)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw NetworkError.serverError }
            guard let usersResponse = try? JSONDecoder().decode(UsersResponse.self, from: data) else { throw NetworkError.invalidData }
            self.users.append(contentsOf: usersResponse.data)
            self.support = usersResponse.support
        } catch {
            self.error = error
        }
    }
    
    func loadData() {
        Task(priority: .medium) {
            try await fetchUsersAsync()
        }
    }
}
