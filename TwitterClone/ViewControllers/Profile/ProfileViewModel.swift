//
//  ProfileViewModel.swift
//  TwitterClone
//
//  Created by Osmancan Akagündüz on 5.06.2023.
//

import Foundation
import Combine
import Firebase

class ProfileViewModel : ObservableObject {
    @Published var user : UserModel?
    @Published var error: String?
    @Published var tweets: [TweetModel]?

    private var subscriptions: Set<AnyCancellable> = []
    
    func fetchUser()  {
        guard let id = Auth.auth().currentUser?.uid else { return }

        DatabaseManager.instance.fetchUserProfile(id: id).sink { completion in
            if case .failure(let error) = completion {
                self.error = error.localizedDescription
            }
        } receiveValue: { user in
            self.user = user
            self.fetchMyTweets()
        }.store(in: &subscriptions)

    }
    
    func fetchMyTweets()  {
        guard let id = Auth.auth().currentUser?.uid else { return }

        DatabaseManager.instance.fetchMyTweets(authorId: id).sink { completion in
            if case let .failure(error) = completion {
                self.error = error.localizedDescription
            }
        } receiveValue: { list in
            self.tweets = list
        }.store(in: &subscriptions)

    }
    
    
    func convertDate(date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "MMM YYYY"
        return dateFormatter.string(from: date)

    }
}
