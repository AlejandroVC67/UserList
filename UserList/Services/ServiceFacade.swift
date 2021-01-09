//
//  ServiceFacade.swift
//  UserList
//
//  Created by Diego Alejandro Villa Cardenas on 9/01/21.
//

import Foundation

final class ServiceFacade: ServiceProtocol {
    private enum Constants {
        static let url = "https://jsonplaceholder.typicode.com"
    }
    
    private enum HTTPMethods {
        static let get = "GET"
        static let post = "POST"
    }
  
    func getUsers(completion: @escaping UsersServiceResponse) {
        guard let url  = URL(string: Constants.url + "/users") else {
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
                // Save in coredata
                // Retrieve from coredata
                completion(.success(users))
            } catch {
                print(error)
                completion(.failure(.unableToParse))
            }
        }
        task.resume()
    }
    
    func getPosts(completion: @escaping PostsServiceResponse) {
        completion(.failure(.badUrl))
    }
}
