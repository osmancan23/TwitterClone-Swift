//
//  SearchViewController.swift
//  TwitterClone
//
//  Created by Osmancan Akagündüz on 20.05.2023.
//

import UIKit
import Combine
class SearchViewController: UIViewController  {
    
    let searchController = UISearchController()
    let viewModel = SearchViewModel()
    
    var subscriptions : Set<AnyCancellable> = []

    
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
        searchController.automaticallyShowsCancelButton = false
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = searchController.searchBar
        
        bindViews()

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.frame
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchUsers(value: " ")
    }
    
    func bindViews()  {
        viewModel.$users.sink { [weak self] completion in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }.store(in: &subscriptions)
        
        viewModel.$error.sink { error in
            print(error)
        }.store(in: &subscriptions)
       

    }

   

}

extension SearchViewController : UISearchResultsUpdating , UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell else{
            return UITableViewCell()}
        cell.setup(user: viewModel.users![indexPath.row])
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        viewModel.fetchUsers(value: text)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ProfileViewController()
        vc.userId = viewModel.users![indexPath.row].id
        let controller = UINavigationController(rootViewController: vc)
        controller.modalPresentationStyle = .fullScreen
        
        self.present(controller, animated: true)
    }
}
