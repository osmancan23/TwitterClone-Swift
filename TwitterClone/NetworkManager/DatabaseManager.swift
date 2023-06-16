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
    private let followPath = "follows"

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
    
    func fetchMyTweets(authorId:String) -> AnyPublisher<[TweetModel],Error> {
        return firestore.collection(tweetsPath).whereField("authorId", isEqualTo: authorId).getDocuments().tryMap(\.documents).tryMap { snapshots in
            try snapshots.map({
              try  $0.data(as: TweetModel.self)
            })
        }.eraseToAnyPublisher()
    }
    
    func fetchAllTweets() -> AnyPublisher<[TweetModel],Error> {
        return firestore.collection(tweetsPath).order(by: "createdOn",descending: true).getDocuments().tryMap(\.documents).tryMap { snapshots in
            try snapshots.map({
              try  $0.data(as: TweetModel.self)
            })
        }.eraseToAnyPublisher()
    }
    
    
    func fetchUsers(value: String) -> AnyPublisher<[UserModel],Error> {
        print(value)
        return firestore.collection(userPath)
             .whereField("displayName", isGreaterThanOrEqualTo: value)
            .whereField("displayName", isLessThan: value + "z").getDocuments().tryMap(\.documents).tryMap { snapshots in
                try snapshots.map({
                    try $0.data(as: UserModel.self)
                })
            }.eraseToAnyPublisher()
    }
    
    
    func followUser(follow:FollowModel) -> AnyPublisher<Bool,Error> {
        return firestore.collection(followPath).document(follow.id).setData(from: follow).map{
            _ in return true
        }.eraseToAnyPublisher()
    }
    
    func unFollowUser(follow:FollowModel) -> AnyPublisher<Bool,Error> {
        return Future<Bool, Error> { promise in
            self.firestore.collection(self.followPath)
                  .whereField("follower", isEqualTo: follow.follower)
                  .whereField("following", isEqualTo: follow.following)
                  .getDocuments { (snapshot, error) in
                      if let error = error {
                          print("Hata: \(error.localizedDescription)")
                          promise(.failure(error))
                      } else {
                          guard let documents = snapshot?.documents else {
                              print("Silinecek belgeler bulunamadı.")
                              promise(.failure(NSError(domain: "", code: 0, userInfo: nil)))
                              return
                          }
                          
                          let batch = self.firestore.batch()
                          
                          for document in documents {
                              batch.deleteDocument(document.reference)
                          }
                          
                          batch.commit { (error) in
                              if let error = error {
                                  print("Belgeler silinirken hata oluştu: \(error.localizedDescription)")
                                  promise(.failure(error))
                              } else {
                                  print("Belgeler başarıyla silindi.")
                                  promise(.success(true))
                              }
                          }
                      }
                  }
          }.eraseToAnyPublisher()
    }
    
    func checkFollowStatus(follow:FollowModel) -> AnyPublisher<Bool,Error> {
        return Future<Bool, Error> { promise in
            self.firestore.collection(self.followPath)
                  .whereField("follower", isEqualTo: follow.following)
                  .whereField("following", isEqualTo: follow.follower)
                  .getDocuments { (snapshot, error) in
                      if let error = error {
                          print("Hata: \(error.localizedDescription)")
                          promise(.failure(error))
                      } else {
                          
                           (snapshot?.documents.isEmpty) ?? false ? promise(.success(false)):promise(.success(true))
                      }
                  }
          }.eraseToAnyPublisher()
    }
    
    func fetchFollowingCount(userId:String) -> AnyPublisher<Int,Error> {
        return Future<Int,Error> { promise in
            self.firestore.collection(self.followPath)
                .whereField("following", isEqualTo: userId).getDocuments { (snapshot, error) in
                    if let error = error {
                        print("Hata: \(error.localizedDescription)")
                        promise(.failure(error))
                    } else {
                        
                        promise(.success(snapshot?.documents.count ?? 0))
                    }
                    
                    
                }
        }.eraseToAnyPublisher()
    }
    
    func fetchFollowerCount(userId:String) -> AnyPublisher<Int,Error> {
        return Future<Int,Error> { promise in
            self.firestore.collection(self.followPath)
                .whereField("follower", isEqualTo: userId).getDocuments { (snapshot, error) in
                    if let error = error {
                        print("Hata: \(error.localizedDescription)")
                        promise(.failure(error))
                    } else {
                        
                        promise(.success(snapshot?.documents.count ?? 0))
                    }
                    
                    
                }
        }.eraseToAnyPublisher()
    }
}

