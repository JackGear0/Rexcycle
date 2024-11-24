//
//  User.swift
//  Rexcycle
//
//  Created by Pedro Catunda on 24/11/24.
//

import Foundation

struct User: Codable, Identifiable {
    var id: UUID?
    var username: String
    var name: String
    var avatar: String?
    var credit: Double
    var is_enterprise: Bool
}

extension User {
    struct Create: Encodable {
        var username: String
        var name: String?
        var avatar: String?
        var password: String
        var isEnterprise: Bool
    }
}

struct Session: Decodable {
    let token: String
    let user: User
}
