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

    private var cachedUsers: [UserModel] = [] {
        didSet {
            displayedUsers = cachedUsers
            delegate?.reload()
        }
    }
    private(set) var displayedUsers: [UserModel] = []
    private let serviceHandler: ServiceProtocol
    weak var delegate: UserListDelegate?
    
    init(service: ServiceProtocol) {
        self.serviceHandler = service
    }
    
    func filterUser(by string: String) {
        // TODO: Finish coredata implementation, always returning empty array.
        let predicate = NSPredicate(format: "name CONTAINS '%@'", string)
        let matchingUsers = CacheManager.retrieveBasedOn(predicate: predicate)
        
        if string.isEmpty {
            displayedUsers = cachedUsers
            delegate?.reload()
            return
        }
        
        displayedUsers = cachedUsers.filter({ $0.name.contains(string) })
        delegate?.reload()
    }
    
    func fetchUsers() {
        serviceHandler.getUsers { [weak self] (result) in
            guard let self = self else { return }
            self.delegate?.startActivityIndicator()
            switch result {
            case .success(let users):
                self.cachedUsers = users
            case .failure(let error): print("error description: ", error.errorDescription as Any)
                
            }
            self.delegate?.stopActivityIndicator()
        }
    }
    
    private func getUser(pos: Int) -> UserModel {
        return displayedUsers[pos]
    }
}

extension UserListViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UserTableViewCell()
        cell.delegate = delegate
        let user = getUser(pos: indexPath.row)
        cell.setupView(with: user)
        return cell
    }
}
