//
//  ServiceProtocol.swift
//  UserList
//
//  Created by Diego Alejandro Villa Cardenas on 9/01/21.
//

import Foundation

typealias UsersServiceResponse = (Result<[User], ServiceError>) -> Void
typealias PostsServiceResponse = (Result<[PostModel], ServiceError>) -> Void

protocol ServiceProtocol {
    func getUsers(completion: @escaping UsersServiceResponse)
    func getPosts(completion: @escaping PostsServiceResponse)
}

