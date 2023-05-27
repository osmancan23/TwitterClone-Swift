//
//  HomeViewController.swift
//  TwitterClone
//
//  Created by Osmancan Akagündüz on 20.05.2023.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    var timelineTableView : UITableView = {
        let tableView = UITableView()
        tableView.register(TweetTableViewCell.self,  forCellReuseIdentifier: TweetTableViewCell.identifier)
        return tableView
        
    }()
    
    @objc func onClickProfile()  {
        navigationController?.pushViewController(ProfileViewController(), animated: true)
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
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(timelineTableView)
        timelineTableView.delegate = self
        timelineTableView.dataSource = self
        configureAppbar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        timelineTableView.frame = view.frame
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
    
        handleAuthStatus()
    }

}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as? TweetTableViewCell else {
                   return UITableViewCell()
               }
               
               return cell
    }
    
  
    
}
