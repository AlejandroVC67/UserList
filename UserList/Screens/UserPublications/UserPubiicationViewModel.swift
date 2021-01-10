//
//  UserPubiicationViewModel.swift
//  UserList
//
//  Created by Diego Alejandro Villa Cardenas on 10/01/21.
//

import Foundation
import UIKit

protocol UserPublicationDelegate: UITableViewController {
    func reload()
}

final class UserPubiicationViewModel: NSObject {
    private let user: User
    private let serviceHandler: ServiceProtocol = ServiceFacade()
    private var publications: [PostModel] = [] {
        didSet {
            delegate?.reload()
        }
    }
    var delegate: UserPublicationDelegate?
    
    init(user: User) {
        self.user = user
    }
    
    func retrievePublications() {
        let id = String(user.id)
        serviceHandler.getPosts(userId: id) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let posts):
                self.publications = posts
            case .failure(let error): print("Error \(String(describing: error.errorDescription)) while fetching publications for user \(self.user.name)")
            }
        }
    }
    
    func getUsername() -> String {
        return String(format: "%@ %@", user.name, "Posts")
    }
    
    func getPost(pos: Int) -> PostModel {
        return publications[pos]
    }
}

extension UserPubiicationViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return publications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PublicationTableViewCell()
        let post = getPost(pos: indexPath.row)
        cell.setupView(post: post)
        return cell
    }
}
