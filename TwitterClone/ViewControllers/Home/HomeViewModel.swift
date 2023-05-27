//
//  HomeViewModel.swift
//  TwitterClone
//
//  Created by Osmancan Akagündüz on 27.05.2023.
//

import Foundation
import Combine
import Firebase

final class HomeViewModel : ObservableObject {
    @Published var user : UserModel?
    @Published var error: String?
        
    private var subscriptions: Set<AnyCancellable> = []
    
    func fetchUser()  {
        guard let id = Auth.auth().currentUser?.uid else { return }

        DatabaseManager.instance.fetchUserProfile(id: id).sink { completion in
            if case .failure(let error) = completion {
                self.error = error.localizedDescription
            }
        } receiveValue: { user in
            self.user = user
        }.store(in: &subscriptions)

    }
}
