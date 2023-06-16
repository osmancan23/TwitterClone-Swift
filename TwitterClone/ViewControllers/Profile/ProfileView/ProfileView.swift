//
//  ProfileView.swift
//  TwitterClone
//
//  Created by Osmancan Akagündüz on 13.06.2023.
//

import UIKit

class ProfileView: UIView {

    let profileTableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints=false
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        return tableView
    }()
    
   
}
