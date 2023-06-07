//
//  TweetComposeViewModel.swift
//  TwitterClone
//
//  Created by Osmancan Akagündüz on 6.06.2023.
//

import Foundation
import Firebase
import Combine

class TweetComposeViewModel : ObservableObject {
    @Published var user : UserModel?
    @Published var error: String?
    var tweetContent : String  = ""
    @Published var isValidate  = false
    @Published var isCompleted  = false

    var subscriptions : Set<AnyCancellable> = []
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
    
    func validate()  {
       isValidate = !tweetContent.isEmpty
    }
    
    func sendTweet()  {
        let tweet = TweetModel(author: user!, authorId: user!.id, content: tweetContent, likeCount: 0, likers: [], isReply: false, parentReference: nil)
        
        DatabaseManager.instance.saveTweet(tweet: tweet).sink { [weak self] completion in
            switch completion {
            case .failure(let error):
                self?.error = error.localizedDescription
            case .finished:
                self?.isCompleted = true
            }
        } receiveValue: { state in
            self.isCompleted = state
        }.store(in: &subscriptions)


    }
}
