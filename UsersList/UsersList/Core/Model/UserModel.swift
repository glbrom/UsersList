//
//  UserModel.swift
//  UsersList
//
//  Created by Roman Golub on 25.03.2025.
//

import Foundation

struct UsersResponse: Codable {
    let page: Int
    let perPage: Int
    let total: Int
    let totalPages: Int
    let data: [User]
    let support: Support
    
    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data
        case support
    }
}

struct User: Codable, Identifiable, Hashable {
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
    let avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id, email, avatar
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

struct Support: Codable {
    let url: String
    let text: String
}

extension User {
    static let usersPreview: [User] = [
        User(id: 1, email: "george@gmail.com", firstName: "George", lastName: "Kan", avatar: "https://reqres.in/img/faces/2-image.jpg"),
        User(id: 2, email: "janet_terry@ukr.net", firstName: "Ron", lastName: "Jack", avatar: "https://reqres.in/img/faces/4-image.jpg"),
        User(id: 3, email: "emma.wong@gmail.com", firstName: "Emma", lastName: "Li", avatar: "https://reqres.in/img/faces/3-image.jpg")
    ]
}
