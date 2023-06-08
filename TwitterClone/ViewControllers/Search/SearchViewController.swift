//
//  SearchViewController.swift
//  TwitterClone
//
//  Created by Osmancan Akagündüz on 20.05.2023.
//

import UIKit

class SearchViewController: UIViewController  {
    
    let searchController = UISearchController()
    
    
    var tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(UserTableViewCell.self,  forCellReuseIdentifier: UserTableViewCell.identifier)
        return tableView
        
    }()
    
    func configureConstraints()  {
        let tableViewConstraints = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(tableViewConstraints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        searchController.searchResultsUpdater = self
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = searchController.searchBar

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.frame
    }

   

}

extension SearchViewController : UISearchResultsUpdating , UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell else{
            return UITableViewCell()}
        
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        
        print(text)
    }
}
