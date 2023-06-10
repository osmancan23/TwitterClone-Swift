//
//  HomeViewController.swift
//  TwitterClone
//
//  Created by Osmancan Akagündüz on 20.05.2023.
//

import UIKit
import Firebase
import Combine
class HomeViewController: UIViewController {

    let viewModel = HomeViewModel()
    
    private var subscriptions: Set<AnyCancellable> = []

    
   private lazy var tweetButton : UIButton  = {
        let button = UIButton(type: .system, primaryAction: UIAction  {
            [weak self] _ in
            
            self?.navigateToTweetView()
        })
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "plus")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .tweeterColor
        button.cornerRadius = 30
        button.clipsToBounds = false
        return button
    }()
    
    
    var timelineTableView : UITableView = {
        let tableView = UITableView()
        tableView.register(TweetTableViewCell.self,  forCellReuseIdentifier: TweetTableViewCell.identifier)
        return tableView
        
    }()
    
    @objc func onClickProfile()  {
        let vc = ProfileViewController()
        vc.userId = Auth.auth().currentUser?.uid
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToTweetView()  {
        let vc = UINavigationController(rootViewController: TweetComposeViewController())
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true)
        
       /* let vc = TweetComposeViewController()
        
        navigationController?.pushViewController(vc, animated: true)*/
    }
    private func configureAppbar (){
        let size : CGFloat = 36
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "twitterLogo")
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        imageView.image = image
        view.addSubview(imageView)
        
        navigationItem.titleView  = view
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(onClickProfile))
       
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .done, target: self, action: #selector(signOut))
    }
    
    func configureConstraints()  {
        let tweetButtonConstraints = [
            tweetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tweetButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            tweetButton.widthAnchor.constraint(equalToConstant: 60),
            tweetButton.heightAnchor.constraint(equalToConstant: 60),
        ]
        
        NSLayoutConstraint.activate(tweetButtonConstraints)
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(timelineTableView)
        view.addSubview(tweetButton)
        timelineTableView.delegate = self
        timelineTableView.dataSource = self
        configureAppbar()
        bindViews()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        timelineTableView.frame = view.frame
        configureConstraints()
    }
    
   @objc private func signOut()  {
      try? Auth.auth().signOut()
       handleAuthStatus()
       
    }
    
    private func handleAuthStatus() {
        if Auth.auth().currentUser == nil {
            let vc = UINavigationController(rootViewController: OnboardViewController())
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
    func completeUserOnboarding() {
           let vc = ProfileCompleteViewController()
           present(vc, animated: true)
       }
    
    func bindViews()  {
        viewModel.$user.sink { user in
            guard let user = user else {return }
            
            if !user.isUserOnboarded {
                self.completeUserOnboarding()
            }
        }.store(in: &subscriptions)
        
        viewModel.$tweets.sink { [weak self] tweets in
            DispatchQueue.main.async {
                self?.timelineTableView.reloadData()

            }
        }.store(in: &subscriptions)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        handleAuthStatus()
        
        viewModel.fetchUser()
    }

}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tweets?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as? TweetTableViewCell else {
                   return UITableViewCell()
               }
        cell.setup(tweet: viewModel.tweets![indexPath.row])
        
        return cell
    }
    
  
    
}
