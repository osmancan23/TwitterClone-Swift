//
//  TweetTableViewCell.swift
//  TwitterClone
//
//  Created by Osmancan Akagündüz on 21.05.2023.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    static let identifier = "TweetTableViewCell"
    
    private let actionSpacing: CGFloat = 60

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
      
      private let tweetTextContentLabel: UILabel = {
          let label = UILabel()
          label.translatesAutoresizingMaskIntoConstraints = false
         
          label.numberOfLines = 0
          return label
          
      }()
    
    private let replyButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "bubble.left"), for: .normal)
        button.tintColor = .systemGray2
        return button
    }()
    
    private let retweetButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.2.squarepath"), for: .normal)
        button.tintColor = .systemGray2
        return button
    }()
    
    private let likeButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .systemGray2
        return button
    }()
    
    private let shareButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .systemGray2
        return button
    }()
    
    
    
    private func configureConstraints(){
    
        let avatarImageViewConstraints = [
                   avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
                   avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
                   avatarImageView.heightAnchor.constraint(equalToConstant: 50),
                   avatarImageView.widthAnchor.constraint(equalToConstant: 50)
               ]
               
               
               let displayNameLabelConstraints = [
                   displayNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20),
                   displayNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20)
               ]
               
               let usernameLabelConstraints = [
                   usernameLabel.leadingAnchor.constraint(equalTo: displayNameLabel.trailingAnchor, constant: 10),
                   usernameLabel.centerYAnchor.constraint(equalTo: displayNameLabel.centerYAnchor)
               ]
               
               let tweetTextContentLabelConstraints = [
                   tweetTextContentLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
                   tweetTextContentLabel.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor, constant: 10),
                   tweetTextContentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
               ]
        
            let replyButtonConstraints = [
                replyButton.leadingAnchor.constraint(equalTo:  tweetTextContentLabel.leadingAnchor),
                replyButton.topAnchor.constraint(equalTo: tweetTextContentLabel.bottomAnchor,constant: 10),
                replyButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
            ]
        
        let retweetButtonConstraints = [
            retweetButton.leadingAnchor.constraint(equalTo: replyButton.trailingAnchor, constant: actionSpacing),
            retweetButton.centerYAnchor.constraint(equalTo: replyButton.centerYAnchor),
        ]
        
        let likeButtonConstraints = [
            likeButton.leadingAnchor.constraint(equalTo: retweetButton.trailingAnchor, constant: actionSpacing),
            likeButton.centerYAnchor.constraint(equalTo: retweetButton.centerYAnchor),
        ]
        
        let shareButtonConstraints = [
            shareButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: actionSpacing),
            shareButton.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
        ]
        
        NSLayoutConstraint.activate(avatarImageViewConstraints)
        NSLayoutConstraint.activate(displayNameLabelConstraints)
        NSLayoutConstraint.activate(usernameLabelConstraints)
        NSLayoutConstraint.activate(tweetTextContentLabelConstraints)
        NSLayoutConstraint.activate(replyButtonConstraints)
        NSLayoutConstraint.activate(retweetButtonConstraints)
        NSLayoutConstraint.activate(likeButtonConstraints)
        NSLayoutConstraint.activate(shareButtonConstraints)

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(avatarImageView)
        contentView.addSubview(displayNameLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(tweetTextContentLabel)
        contentView.addSubview(replyButton)
        contentView.addSubview(retweetButton)
        contentView.addSubview(likeButton)
        contentView.addSubview(shareButton)

        configureConstraints()
        
        
    }
    
    func setup(tweet:TweetModel)  {
        usernameLabel.text = "@\(tweet.author.username)"
        avatarImageView.sd_setImage(with: URL(string: tweet.author.avatarPath))
        displayNameLabel.text = tweet.author.displayName
        tweetTextContentLabel.text = tweet.content
    }
   
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
