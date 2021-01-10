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
    
}

final class UserListViewModel: NSObject {

    private var cachedUsers: [User] = [] {
        didSet {
            displayedUsers = cachedUsers
            delegate?.reload()
        }
    }
    private var displayedUsers: [User] = []
    private let serviceHandler: ServiceProtocol = ServiceFacade()
    weak var delegate: UserListDelegate?
    
    func filterUser(by string: String) {
//        let predicate = NSPredicate(format: "name = %@", string)
        if string.isEmpty {
            displayedUsers = cachedUsers
            delegate?.reload()
            return
        }
        displayedUsers = cachedUsers.filter({ $0.name.contains(string) })
//        let nsUsers = users as? NSArray
//        self.users = nsUsers?.filtered(using: predicate) as? [UserModel] ?? []
        delegate?.reload()
    }
    
    func fetchUsers() {
        serviceHandler.getUsers { [weak self] (result) in
            guard let self = self else { return }
            self.delegate?.startActivityIndicator()
            switch result {
            case .success(let users):
                self.cachedUsers = users
            case .failure(let error): print("error description: ", error.errorDescription)
                
            }
            self.delegate?.stopActivityIndicator()
        }
    }
    
    private func getUser(pos: Int) -> User {
        return displayedUsers[pos]
    }
}

extension UserListViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UserTableViewCell()
        let user = getUser(pos: indexPath.row)
        cell.setupView(with: user)
        return cell
    }
}
