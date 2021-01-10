//
//  UserModel.swift
//  UserList
//
//  Created by Diego Alejandro Villa Cardenas on 9/01/21.
//

import Foundation

struct UserModel: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
}
