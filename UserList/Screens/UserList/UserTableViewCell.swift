//
//  UserTableViewCell.swift
//  UserList
//
//  Created by Diego Alejandro Villa Cardenas on 9/01/21.
//

import UIKit

final class UserTableViewCell: UITableViewCell {

    private enum Constants {
        enum NameTitleLabel {
            static let padding: UIEdgeInsets = .init(top: 20, left: 4, bottom: 0, right: 0)
        }
 
        enum ProfileImage {
            static let dimensions: CGFloat = 100
            static let padding: UIEdgeInsets = .init(top: 20, left: 10, bottom: -20, right: 0)
            static let configuration = UIImage.SymbolConfiguration(scale: .large)
            static let image = UIImage(systemName: "person.crop.circle", withConfiguration: configuration)
        }
        
        enum NameLabel {
            static let padding: UIEdgeInsets = .init(top: 20, left: 20, bottom: 0, right: -8)
            static let font: UIFont = UIFont.systemFont(ofSize: 20, weight: .bold)
        }
        
        enum PhoneIcon {
            static let padding: UIEdgeInsets = .init(top: 10, left: 0, bottom: 0, right: 0)
            static let dimensions: CGFloat = 20
            static let image = UIImage(systemName: "phone.fill")
        }
        
        enum PhoneLabel {
            static let padding: UIEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: -8)
        }
        
        enum EmailIcon {
            static let padding: UIEdgeInsets = .init(top: 10, left: 0, bottom: 0, right: 0)
            static let dimensions: CGFloat = 20
            static let image = UIImage(systemName: "envelope.fill")
        }
        
        enum EmailLabel {
            static let padding: UIEdgeInsets = .init(top: 0, left: 4, bottom: -20, right: -8)
        }
        
        enum PublicationsButton {
            static let padding: UIEdgeInsets = .init(top: 20, left: 0, bottom: -20, right: 0)
            static let text = "See Posts"
            static let image = UIImage(systemName: "doc.text.fill")
        }
    }
    
    private lazy var profileImageView: UIImageView = {
        let view = UIImageView(image: Constants.ProfileImage.image)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = Constants.NameLabel.font
        return label
    }()
    
    private lazy var phoneIcon: UIImageView = {
        let view = UIImageView(image: Constants.PhoneIcon.image)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var emailIcon: UIImageView = {
        let view = UIImageView(image: Constants.EmailIcon.image)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private lazy var publicationsButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.PublicationsButton.text, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.blue, for: .normal)
        button.setImage(Constants.PublicationsButton.image, for: .normal)
        return button
    }()
    
    weak var delegate: UserListDelegate?
    private var user: UserModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupView(with user: UserModel) {
        // Set labels
        self.user = user
        nameLabel.text = self.user?.name
        phoneLabel.text = self.user?.phone
        emailLabel.text = self.user?.email.lowercased()
        // Setup Constraints
        setupConstraints()
        // Create tap
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        addGestureRecognizer(tap)
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        delegate?.handleTap(user: user)
    }
    
    private func setupConstraints() {
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(phoneIcon)
        addSubview(phoneLabel)
        addSubview(emailIcon)
        addSubview(emailLabel)
        addSubview(publicationsButton)
        
        setupProfileImageViewConstraints()
        setupNameLabelConstraints()
        setupPhoneIconConstraints()
        setupPhoneLabelConstraints()
        setupEmailIconConstraints()
        setupEmailLabelConstraints()
        setupPublicationsButtonConstraints()
    }
    
    private func setupProfileImageViewConstraints() {
        profileImageView.widthAnchor.constraint(equalToConstant: Constants.ProfileImage.dimensions).isActive = true
        profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.ProfileImage.padding.top).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.ProfileImage.padding.bottom).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.PhoneIcon.padding.left).isActive = true
    }
    
    private func setupNameLabelConstraints() {
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.NameLabel.padding.top).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: Constants.NameLabel.padding.left).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.NameLabel.padding.right).isActive = true
    }
    
    private func setupPhoneIconConstraints() {
        phoneIcon.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constants.PhoneIcon.padding.top).isActive = true
        phoneIcon.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        phoneIcon.widthAnchor.constraint(equalToConstant: Constants.PhoneIcon.dimensions).isActive = true
        phoneIcon.heightAnchor.constraint(equalToConstant: Constants.PhoneIcon.dimensions).isActive = true
    }
    
    private func setupPhoneLabelConstraints() {
        phoneLabel.topAnchor.constraint(equalTo: phoneIcon.topAnchor).isActive = true
        phoneLabel.leadingAnchor.constraint(equalTo: phoneIcon.trailingAnchor, constant: Constants.PhoneLabel.padding.left).isActive = true
        phoneLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.PhoneLabel.padding.right).isActive = true
    }
    
    private func setupEmailIconConstraints() {
        emailIcon.topAnchor.constraint(equalTo: phoneIcon.bottomAnchor, constant: Constants.EmailIcon.padding.top).isActive = true
        emailIcon.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        emailIcon.widthAnchor.constraint(equalToConstant: Constants.EmailIcon.dimensions).isActive = true
        emailIcon.heightAnchor.constraint(equalToConstant: Constants.EmailIcon.dimensions).isActive = true
    }
    
    private func setupEmailLabelConstraints() {
        emailLabel.topAnchor.constraint(equalTo: emailIcon.topAnchor).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: emailIcon.trailingAnchor, constant: Constants.EmailLabel.padding.left).isActive = true
        emailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.EmailLabel.padding.right).isActive = true
    }
    
    private func setupPublicationsButtonConstraints() {
        publicationsButton.topAnchor.constraint(equalTo: emailIcon.bottomAnchor, constant: Constants.PublicationsButton.padding.top).isActive = true
        publicationsButton.leadingAnchor.constraint(equalTo: emailIcon.leadingAnchor).isActive = true
        publicationsButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.PublicationsButton.padding.bottom).isActive = true
    }
    
}
