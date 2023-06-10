//
//  SearchViewModel.swift
//  TwitterClone
//
//  Created by Osmancan Akagündüz on 9.06.2023.
//

import Foundation
import Combine
class SearchViewModel : ObservableObject {
    
    @Published var users : [UserModel]?
    @Published var error : String?
    
    
    var subscriptions : Set<AnyCancellable> = []
    
    
    func fetchUsers(value:String)  {
        DatabaseManager.instance.fetchUsers(value: value).sink { completion in
            if case .failure(let error) = completion {
                
                self.error = error.localizedDescription
            }
        } receiveValue: { [weak self] list in
            print(list)
            self?.users = list
        }.store(in: &subscriptions)

    }
    
    
    
    
}
