//
//  UserListViewController.swift
//  UserList
//
//  Created by Diego Alejandro Villa Cardenas on 9/01/21.
//

import UIKit

final class UserListViewController: UIViewController {

    private var viewModel = UserListViewModel(service: ServiceFacade())
    
    private enum Constants {
        enum NavBar {
            static let title = "User List"
        }
        
        enum SearchBar {
            static let heightAnchor: CGFloat = 40
            static let topAnchor: CGFloat = 15
            static let placeholder = "Search user"
        }
        
        enum TableView {
            static let topAnchor: CGFloat = 15
        }
    }
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.style = .large
        indicator.color = .blue
        return indicator
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.dataSource = viewModel
        view.rowHeight = UITableView.automaticDimension
        view.separatorStyle = .singleLine
        view.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.reuseIdentifier)
        return view
    }()
    
    private lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.placeholder = Constants.SearchBar.placeholder
        bar.searchBarStyle = .minimal
        bar.delegate = self
        return bar
    }()
    
    private var errorView: UserListEmptyView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupView()
        viewModel.fetchUsers()
    }
    
    private func setupView() {
        title = Constants.NavBar.title
        view.backgroundColor = .white
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.SearchBar.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: Constants.SearchBar.heightAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: Constants.TableView.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension UserListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterUser(by: searchText)
    }
}


extension UserListViewController: UserListDelegate {
    func startActivityIndicator() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.view.addSubview(self.activityIndicator)
            
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            
            self.activityIndicator.startAnimating()
        }
    }
    
    func stopActivityIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.removeFromSuperview()
        }
    }
    
    func reload() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            
        }
    }
    
    func handleTap(user: UserModel?) {
        guard let user = user else { return }
        
        let viewModel = UserPublicationViewModel(user: user, service: ServiceFacade())
        let controller = UserPublicationsTableViewController(viewModel: viewModel)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func showError() {
        guard errorView == nil else {
            return
        }
        
        let view = UserListEmptyView()
        view.setupView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        errorView = view
        guard let errorView = errorView else {
            return
        }
        self.view.addSubview(errorView)
        
        view.topAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: tableView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
    }
    
    func dismissError() {
        if errorView != nil {
            errorView?.removeFromSuperview()
            errorView = nil
        }
    }
}

