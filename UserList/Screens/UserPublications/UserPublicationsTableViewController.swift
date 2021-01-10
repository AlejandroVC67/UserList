//
//  UserPublicationsTableViewController.swift
//  UserList
//
//  Created by Diego Alejandro Villa Cardenas on 10/01/21.
//

import UIKit

final class UserPublicationsTableViewController: UITableViewController {

    private var viewModel: UserPubiicationViewModel
    
    init(viewModel: UserPubiicationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.getUsername()
        viewModel.delegate = self
        setupTableView()
        viewModel.retrievePublications()
    }
    
    private func setupTableView() {
        tableView.dataSource = viewModel
        tableView.allowsSelection = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PublicationTableViewCell.self, forCellReuseIdentifier: PublicationTableViewCell.reuseIdentifier)
    }
}

extension UserPublicationsTableViewController: UserPublicationDelegate {
    func reload() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
