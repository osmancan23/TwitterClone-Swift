//
//  DatabaseManager.swift
//  TwitterClone
//
//  Created by Osmancan Akagündüz on 27.05.2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestoreCombineSwift
import Combine

class DatabaseManager {
    
    static let instance = DatabaseManager()
    
    private let userPath =  "users"
    private let tweetsPath = "tweets"
    private let firestore = Firestore.firestore()
    
    func createUserProfile(user:User) -> AnyPublisher<Bool,Error>  {
        let model = UserModel(from: user)
        
      return  firestore.collection(userPath).document(model.id).setData(from: model).map { _ in return true }
            .eraseToAnyPublisher()
    }
    
    func fetchUserProfile(id:String) -> AnyPublisher<UserModel,Error> {
      return  firestore.collection(userPath).document(id).getDocument()
                    .tryMap { try $0.data(as: UserModel.self) }
                    .eraseToAnyPublisher()
    }
    
    func updateUserProfile(data: [String:Any], id:String) -> AnyPublisher<Bool,Error> {
        return firestore.collection(userPath).document(id).updateData(data).tryMap() { _ in return true }
            .eraseToAnyPublisher()
    }
    
    func saveTweet(tweet:TweetModel) -> AnyPublisher<Bool,Error> {
        return firestore.collection(tweetsPath).document(tweet.id).setData(from: tweet).map{
            _ in return true
        }.eraseToAnyPublisher()
    }
    
    func fetchTweets(authorId:String) -> AnyPublisher<[TweetModel],Error> {
        return firestore.collection(tweetsPath).whereField("authorId", isEqualTo: authorId).getDocuments().tryMap(\.documents).tryMap { snapshots in
            try snapshots.map({
              try  $0.data(as: TweetModel.self)
            })
        }.eraseToAnyPublisher()
    }
    
}

