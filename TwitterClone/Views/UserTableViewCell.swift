//
//  UserTableViewCell.swift
//  TwitterClone
//
//  Created by Osmancan Akagündüz on 8.06.2023.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    static let identifier = "TweetTableViewCell"

    private let avatarImageView: UIImageView = {
         
          let imageView = UIImageView()
          imageView.translatesAutoresizingMaskIntoConstraints = false
          imageView.contentMode = .scaleAspectFill
          imageView.layer.cornerRadius = 25
          imageView.layer.masksToBounds = true
          imageView.clipsToBounds = true
          imageView.backgroundColor = .red
          return imageView
      }()
      
      
      private let displayNameLabel: UILabel = {
          let label = UILabel()
          label.font = .systemFont(ofSize: 18, weight: .bold)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
      
      private let usernameLabel: UILabel = {
          let label = UILabel()
          label.textColor = .secondaryLabel
          label.font = .systemFont(ofSize: 16, weight: .regular)
          label.translatesAutoresizingMaskIntoConstraints = false

          return label
      }()

    
    func configureConstraints()  {
        
        let avatarImageConstraints = [
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let displayLabelConstraints = [
            displayNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20),
            displayNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
        ]
        
        let usernameLabelConstraints = [
            usernameLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            usernameLabel.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor, constant: 5),
        ]
        
        let contentViewConstraints = [
            contentView.heightAnchor.constraint(equalToConstant: 70)
        ]
        
        NSLayoutConstraint.activate(avatarImageConstraints)
        NSLayoutConstraint.activate(displayLabelConstraints)
        NSLayoutConstraint.activate(usernameLabelConstraints)
        NSLayoutConstraint.activate(contentViewConstraints)

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(avatarImageView)
        contentView.addSubview(displayNameLabel)
        contentView.addSubview(usernameLabel)

        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(user:UserModel)  {
        avatarImageView.sd_setImage(with: URL(string: user.avatarPath))
        displayNameLabel.text = user.displayName
        usernameLabel.text = user.username
    }
}
