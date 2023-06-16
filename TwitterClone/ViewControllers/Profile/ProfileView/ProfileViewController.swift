//
//  ProfileViewController.swift
//  TwitterClone
//
//  Created by Osmancan Akagündüz on 21.05.2023.
//

import UIKit
import Combine
import SDWebImage
class ProfileViewController: GenericViewController<ProfileView> {
    
    var userId : String?
    
    let viewModel = ProfileViewModel()
    
    var subcriptions : Set<AnyCancellable> = []
    
    
    
    private func configureConstraints()  {
         let profileTableViewConstraints = [
            
            rootView.profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rootView.profileTableView.topAnchor.constraint(equalTo: view.topAnchor),
            rootView.profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rootView.profileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
     
         ]
        
        NSLayoutConstraint.activate(profileTableViewConstraints)
        
     }
    
     
     lazy  var headerView = ProfileTableViewHeader(frame: CGRect(x: 0, y: 0, width: rootView.profileTableView.frame.width, height: 380), userId: userId!)
     
     


     override func viewDidLoad() {
         super.viewDidLoad()
         navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(goToBack))
         view.addSubview(rootView.profileTableView)
         rootView.profileTableView.dataSource = self
         rootView.profileTableView.delegate = self
         configureConstraints()
         rootView.profileTableView.contentInsetAdjustmentBehavior = .never
     
         rootView.profileTableView.tableHeaderView = headerView
         
         bindViews()
         print("USERID: \(userId)")
     }
     
    @objc func goToBack()  {
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true)
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
                 self?.rootView.profileTableView.reloadData()

             }
         }.store(in: &subcriptions)
     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchUser(userId: userId!)
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
