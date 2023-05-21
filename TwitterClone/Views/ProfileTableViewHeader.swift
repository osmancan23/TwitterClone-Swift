//
//  ProfileTableViewHeader.swift
//  TwitterClone
//
//  Created by Osmancan Akagündüz on 21.05.2023.
//

import UIKit

class ProfileTableViewHeader: UIView {
   
    private let joinedDateLabel: UILabel = {
          
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.text = "Joined May 2021"
           label.textColor = .secondaryLabel
           label.font = .systemFont(ofSize: 14, weight: .regular)
           return label
       }()
       
       private let joinDateImageView: UIImageView = {
           let imageView = UIImageView()
           imageView.image = UIImage(systemName: "calendar", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14))
           imageView.tintColor = .secondaryLabel
           imageView.translatesAutoresizingMaskIntoConstraints = false
           return imageView
       }()
    
    let bioLabel : UILabel = {
        let label = UILabel()
        label.text = "Flutter And Ios Developer"
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userNameLabel : UILabel = {
        let label = UILabel()
        label.text = "@osmancan"
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let displayNameLabel : UILabel = {
        let label = UILabel()
        label.text = "Osmancan Akagunduz"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let backgroundImageView : UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "photo")
        imageView.image = image
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    let profileAvatarImageView : UIImageView = {
       let imageView = UIImageView()
       imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .blue
        let image = UIImage(systemName: "person")
        imageView.image = image
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true

        imageView.cornerRadius = 40
        
        return imageView
    }()
    func configureConstraints()  {
        let backgroundImageConstraints = [
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 150),
        ]
        
        let profileAvatarImageConstraints = [
            profileAvatarImageView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 20),
            profileAvatarImageView.centerYAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 10),

            profileAvatarImageView.widthAnchor.constraint(equalToConstant: 80),
            profileAvatarImageView.heightAnchor.constraint(equalToConstant: 80)
        ]
        
        let displayNameLabelConstraints = [
            displayNameLabel.leadingAnchor.constraint(equalTo: profileAvatarImageView.leadingAnchor),
            displayNameLabel.topAnchor.constraint(equalTo: profileAvatarImageView.bottomAnchor, constant: 10)
        ]
        
        let userNameLabelConstraints = [
            userNameLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            userNameLabel.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor, constant: 5)
        ]
        let bioLabelConstraints = [
            bioLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
            bioLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 5)
        ]
        
        
        let joinDateImageViewConstraints = [
                   joinDateImageView.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
                   joinDateImageView.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 5)
               ]
               
               
               let joinedDateLabelConstraints = [
                   joinedDateLabel.leadingAnchor.constraint(equalTo: joinDateImageView.trailingAnchor, constant: 5),
                   joinedDateLabel.bottomAnchor.constraint(equalTo: joinDateImageView.bottomAnchor)
               ]
        NSLayoutConstraint.activate(backgroundImageConstraints)
        NSLayoutConstraint.activate(profileAvatarImageConstraints)
        NSLayoutConstraint.activate(displayNameLabelConstraints)
        NSLayoutConstraint.activate(userNameLabelConstraints)
        NSLayoutConstraint.activate(bioLabelConstraints)
        NSLayoutConstraint.activate(joinedDateLabelConstraints)
        NSLayoutConstraint.activate(joinDateImageViewConstraints)

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(backgroundImageView)
        addSubview(profileAvatarImageView)
        addSubview(displayNameLabel)
        addSubview(userNameLabel)
        addSubview(bioLabel)
        addSubview(joinedDateLabel)
        addSubview(joinDateImageView)

        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}
