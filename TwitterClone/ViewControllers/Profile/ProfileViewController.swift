//
//  ProfileViewController.swift
//  TwitterClone
//
//  Created by Osmancan Akagündüz on 21.05.2023.
//

import UIKit
import Combine
import SDWebImage
class ProfileViewController: UIViewController {

    let viewModel = ProfileViewModel()
    
    var subcriptions : Set<AnyCancellable> = []
    
    
    
    let profileTableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints=false
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        return tableView
    }()
    
   private func configureConstraints()  {
        let profileTableViewConstraints = [
            profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileTableView.topAnchor.constraint(equalTo: view.topAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    
        ]
       
       NSLayoutConstraint.activate(profileTableViewConstraints)
       
    }
    
    lazy  var headerView = ProfileTableViewHeader(frame: CGRect(x: 0, y: 0, width: profileTableView.frame.width, height: 380))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Profile"
        view.addSubview(profileTableView)
        profileTableView.dataSource = self
        profileTableView.delegate = self
        configureConstraints()
        profileTableView.contentInsetAdjustmentBehavior = .never
        navigationController?.navigationBar.isHidden = true
        profileTableView.tableHeaderView = headerView
        bindViews()
    }
    
    func bindViews()  {
        viewModel.$user.sink { user in
            guard let user = user else {return }
            
            self.headerView.userNameLabel.text = user.username
            self.headerView.bioLabel.text = user.bio
            self.headerView.displayNameLabel.text = user.displayName
            self.headerView.userNameLabel.text = "@\(user.username)"
            self.headerView.profileAvatarImageView.sd_setImage(with: URL(string:user.avatarPath), placeholderImage: UIImage(named: "photo"), options: .allowInvalidSSLCertificates)
            self.headerView.followerCountLabel.text = "\(user.followersCount)"
            self.headerView.followingCountLabel.text = "\(user.followingCount)"
            self.headerView.joinedDateLabel.text = "\(self.viewModel.convertDate(date: user.createdOn))"
        }.store(in: &subcriptions)
        
        viewModel.$tweets.sink { [weak self] tweets in
            DispatchQueue.main.async {
                self?.profileTableView.reloadData()

            }
        }.store(in: &subcriptions)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchUser()
    }
}

extension ProfileViewController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tweets?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as! TweetTableViewCell
        cell.setup(tweet: viewModel.tweets![indexPath.row])
        
        return cell
    }
    
    
}
