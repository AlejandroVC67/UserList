//
//  UserListViewModel.swift
//  UserList
//
//  Created by Diego Alejandro Villa Cardenas on 9/01/21.
//

import Foundation
import UIKit


protocol UserListDelegate where Self: UIViewController {
    func startActivityIndicator()
    func stopActivityIndicator()
    func reload()
    func handleTap(user: UserModel?)
}

final class UserListViewModel: NSObject {

    private(set) var users: [UserModel] = [] {
        didSet {
            delegate?.reload()
        }
    }
    private let serviceHandler: ServiceProtocol
    weak var delegate: UserListDelegate?
    
    init(service: ServiceProtocol) {
        self.serviceHandler = service
    }
    
    func filterUser(by string: String) {
        users = CacheManager.retrieveBasedOn(string: string)
    }
    
    func fetchUsers() {
        serviceHandler.getUsers { [weak self] (result) in
            guard let self = self else { return }
            self.delegate?.startActivityIndicator()
            switch result {
            case .success(let users):
                self.users = users
            case .failure(let error): print("error description: ", error.errorDescription as Any)
                
            }
            self.delegate?.stopActivityIndicator()
        }
    }
    
    private func getUser(pos: Int) -> UserModel {
        return users[pos]
    }
}

extension UserListViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UserTableViewCell()
        cell.delegate = delegate
        let user = getUser(pos: indexPath.row)
        cell.setupView(with: user)
        return cell
    }
}
