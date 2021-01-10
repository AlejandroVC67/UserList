//
//  PublicationTableViewCell.swift
//  UserList
//
//  Created by Diego Alejandro Villa Cardenas on 10/01/21.
//

import UIKit

class PublicationTableViewCell: UITableViewCell {

    private enum Constants {
        enum TitleLabel {
            static let padding: UIEdgeInsets = .init(top: 20, left: 10, bottom: 0, right: -10)
            static let font = UIFont.systemFont(ofSize: 20, weight: .bold)
        }
        
        enum BodyLabel {
            static let padding: UIEdgeInsets = .init(top: 20, left: 10, bottom: -20, right: -10)
            static let font = UIFont.systemFont(ofSize: 16)
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.TitleLabel.font
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.BodyLabel.font
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupView(post: PostModel) {
        titleLabel.text = post.title
        bodyLabel.text = post.body

        setupConstraints()
    }
    
    private func setupConstraints() {
        addSubview(titleLabel)
        addSubview(bodyLabel)
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.TitleLabel.padding.top).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.TitleLabel.padding.left).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.TitleLabel.padding.right).isActive = true
        
        bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.BodyLabel.padding.top).isActive = true
        bodyLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        bodyLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        bodyLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.BodyLabel.padding.bottom).isActive = true
    }
}
