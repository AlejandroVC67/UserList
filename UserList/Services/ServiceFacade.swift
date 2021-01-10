//
//  ServiceFacade.swift
//  UserList
//
//  Created by Diego Alejandro Villa Cardenas on 9/01/21.
//

import Foundation
import UIKit
import CoreData

final class ServiceFacade: ServiceProtocol {
    private enum Constants {
        static let baseUrl = "https://jsonplaceholder.typicode.com"
        static let users = "/users"
        static let posts = "/posts?userId="
    }
    
    private enum HTTPMethods {
        static let get = "GET"
        static let post = "POST"
    }
  
    func getUsers(completion: @escaping UsersServiceResponse) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        
        // First we try to get users from cache
        let cachedUsers = CacheManager.retrieve(from: context)
        if !cachedUsers.isEmpty {
            let result = cachedUsers.transform()
            completion(.success(result))
            return
        }
        
        // If we don't have any stored data, we must consume the service
        guard let url = URL(string: Constants.baseUrl + Constants.users) else {
            completion(.failure(.badUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.get
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, _) in
            guard let data = data else {
                completion(.failure(.dataError))
                return
            }
            do {
                let users = try JSONDecoder().decode([UserModel].self, from: data)
                CacheManager.save(users: users, context: context)
                let cachedUsers = CacheManager.retrieve(from: context)
                let result = cachedUsers.transform()
                completion(.success(result))
            } catch {
                print(error)
                completion(.failure(.unableToParse))
            }
        }
        task.resume()
    }
    
    func getPosts(userId: String, completion: @escaping PostsServiceResponse) {
        let urlPath = Constants.baseUrl + Constants.posts + userId
        
        guard let url = URL(string: urlPath) else {
            completion(.failure(.badUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.get
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, _) in
            guard let data = data else {
                completion(.failure(.dataError))
                return
            }
            do {
                let posts = try JSONDecoder().decode([PostModel].self, from: data)
                completion(.success(posts))
            } catch {
                print(error)
                completion(.failure(.unableToParse))
            }
        }
        task.resume()
    }
}
