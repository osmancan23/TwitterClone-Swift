//
//  ProfileTableViewHeader.swift
//  TwitterClone
//
//  Created by Osmancan Akagündüz on 21.05.2023.
//

import UIKit

class ProfileTableViewHeader: UIView {
   
    private enum TweetBar : String {
        case tweets = "Tweets"
        case tweetsReplies = "Tweets & Replies"
        case media = "Media"
        case likes = "Likes"
        
        
        var index : Int {
            
        switch self {
        case .tweets:
                return 0
        case .tweetsReplies:
           return 1
        case .media:
           return 2
        case .likes:
            return 3
    }
        }
    }
    
    private var selectedIndex : Int = 0 {
        didSet{
            print(selectedIndex)
        }
    }
    
    private var tabs: [UIButton] = ["Tweets", "Tweets & Replies", "Media", "Likes"]
           .map { buttonTitle in
               let button = UIButton(type: .system)
               button.setTitle(buttonTitle, for: .normal)
               button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
               button.tintColor = .label
               button.translatesAutoresizingMaskIntoConstraints = false
               return button
           }
    
    private lazy var sectionStack: UIStackView = {
           let stackView = UIStackView(arrangedSubviews: tabs)
           stackView.translatesAutoresizingMaskIntoConstraints = false
           stackView.distribution = .equalSpacing
           stackView.axis = .horizontal
           stackView.alignment = .center
           return stackView
       }()
    
    func configureStackButtons()  {
        for (i,button) in sectionStack.arrangedSubviews.enumerated() {
            guard let button = button as? UIButton else {return}
            
            button.addTarget(self, action: #selector(onTapTab(_:)), for: .touchUpInside)
        }
    }
   
    @objc private func onTapTab(_ sender: UIButton){

        guard let label = sender.titleLabel?.text as? String else {return}
        
        switch label {
            case TweetBar.tweets.rawValue:
            selectedIndex = 0
        case TweetBar.tweetsReplies.rawValue:
        selectedIndex = 1
        case TweetBar.media.rawValue:
        selectedIndex = 2
        case TweetBar.likes.rawValue:
        selectedIndex = 3
        default:
            selectedIndex = 0
        }
    }
    
    private let followerLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Follower"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private let followerCountLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "323"
        label.textColor = .label
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    
    private let followingLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Following"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private let followingCountLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "311"
        label.textColor = .label
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
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
        
        let followingCountLabelConstraints = [
            followingCountLabel.leadingAnchor.constraint(equalTo: joinDateImageView.leadingAnchor),
            followingCountLabel.topAnchor.constraint(equalTo: joinDateImageView.bottomAnchor,constant: 10)
        ]
        
        let followingLabelConstraints = [
            followingLabel.leadingAnchor.constraint(equalTo: followingCountLabel.trailingAnchor, constant:  7),
            followingLabel.bottomAnchor.constraint(equalTo: followingCountLabel.bottomAnchor)
        ]
        
        let followerCountLabelConstraints = [
            followerCountLabel.leadingAnchor.constraint(equalTo: followingLabel.trailingAnchor,constant: 10),
            followerCountLabel.bottomAnchor.constraint(equalTo: followingLabel.bottomAnchor)
        ]
        
        let followerLabelConstraints = [
            followerLabel.leadingAnchor.constraint(equalTo: followerCountLabel.trailingAnchor,constant: 7),
            followerLabel.bottomAnchor.constraint(equalTo: followerCountLabel.bottomAnchor)
        ]
        
        let sectionStackConstraints = [
                   sectionStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
                   sectionStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
                   sectionStack.topAnchor.constraint(equalTo: followingCountLabel.bottomAnchor, constant: 5),
                   sectionStack.heightAnchor.constraint(equalToConstant: 35)
               ]
        
        NSLayoutConstraint.activate(backgroundImageConstraints)
        NSLayoutConstraint.activate(profileAvatarImageConstraints)
        NSLayoutConstraint.activate(displayNameLabelConstraints)
        NSLayoutConstraint.activate(userNameLabelConstraints)
        NSLayoutConstraint.activate(bioLabelConstraints)
        NSLayoutConstraint.activate(joinedDateLabelConstraints)
        NSLayoutConstraint.activate(joinDateImageViewConstraints)
        NSLayoutConstraint.activate(followingCountLabelConstraints)
        NSLayoutConstraint.activate(followingLabelConstraints)
        NSLayoutConstraint.activate(followerCountLabelConstraints)
        NSLayoutConstraint.activate(followerLabelConstraints)
        NSLayoutConstraint.activate(sectionStackConstraints)

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
        addSubview(followingCountLabel)
        addSubview(followingLabel)
        addSubview(followerCountLabel)
        addSubview(followerLabel)
        addSubview(sectionStack)
        configureConstraints()
        configureStackButtons()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}
