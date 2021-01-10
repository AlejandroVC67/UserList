//
//  UserListEmptyView.swift
//  UserList
//
//  Created by Diego Alejandro Villa Cardenas on 10/01/21.
//

import UIKit

class UserListEmptyView: UIView {
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.text = "List is Empty"
        return label
    }()
    
    
    
    func setupView() {
        backgroundColor = .white
        addSubview(errorLabel)
        
        errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
