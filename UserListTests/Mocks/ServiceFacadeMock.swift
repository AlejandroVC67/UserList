//
//  ServiceFacadeMock.swift
//  UserListTests
//
//  Created by Diego Alejandro Villa Cardenas on 10/01/21.
//

import Foundation
@testable import UserList

class ServiceFacadeMock: ServiceProtocol {
    
    func getUsers(completion: @escaping UsersServiceResponse) {
        guard let data = loadJson(filename: "UsersMock") else {
            completion(.failure(.unableToParse))
            return
        }
        do {
            let users = try JSONDecoder().decode([UserModel].self, from: data)
            completion(.success(users))
        }
        catch {
            completion(.failure(.unableToParse))
        }
    }
    
    func getPosts(userId: String, completion: @escaping PostsServiceResponse) {
        guard let data = loadJson(filename: "UserPostsMock") else {
            completion(.failure(.unableToParse))
            return
        }
        do {
            let posts = try JSONDecoder().decode([PostModel].self, from: data)
            completion(.success(posts))
        }
        catch {
            completion(.failure(.unableToParse))
        }
    }
    
    private func loadJson(filename fileName: String) -> Data? {
        guard let url = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "json") else {
            return nil
        }

        let data = try? Data(contentsOf: URL(fileURLWithPath: url))
        return data
    }
}
