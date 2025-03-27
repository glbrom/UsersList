//
//  UserModel+Realm.swift
//  UsersList
//
//  Created by Roman Golub on 26.03.2025.
//

import RealmSwift

class UserFavoriteRealm: Object, Identifiable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var avatar: String
    @Persisted var firstName: String
    @Persisted var lastName: String
    @Persisted var email: String
    
}

extension User {
    func toRealmModel() -> UserFavoriteRealm {
        let realmModel = UserFavoriteRealm()
        realmModel.id = self.id
        realmModel.avatar = self.avatar
        realmModel.firstName = self.firstName
        realmModel.lastName = self.lastName
        realmModel.email = self.email
        
        return realmModel
    }
    
    init(from realmModel: UserFavoriteRealm) {
        self.id = realmModel.id
        self.avatar = realmModel.avatar
        self.firstName = realmModel.firstName
        self.lastName = realmModel.lastName
        self.email = realmModel.email
    }
}
