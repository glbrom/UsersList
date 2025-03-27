//
//  UserStoraheServiceRealm.swift
//  UsersList
//
//  Created by Roman Golub on 26.03.2025.
//

import RealmSwift

final class UserStorageServiceRealm {
    private var realm: Realm
    
    init() {
        do {
            realm = try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error)")
        }
    }
    
    func addFavorite(user: User) {
        do {
            try realm.write {
                let realmUser = user.toRealmModel()
                realm.add(realmUser, update: .modified)
                print("Added favorite: \(user.id)")
            }
        } catch {
            print("Error adding favorite: \(error)")
        }
    }
    
    func removeFavorite(userId: Int) {
        if let userToDelete = realm.object(ofType: UserFavoriteRealm.self, forPrimaryKey: userId) {
            do {
                try realm.write {
                    realm.delete(userToDelete)
                }
            } catch {
                print("Error removing favorite: \(error)")
            }
        }
    }
    
    func isFavorite(userId: Int) -> Bool {
        return realm.object(ofType: UserFavoriteRealm.self, forPrimaryKey: userId) != nil
    }
    
    func getFavorites() -> [User] {
        let results = realm.objects(UserFavoriteRealm.self)
        print("Favorites count: \(results.count)")
        return Array(results.map { User(from: $0) })
    }
}
