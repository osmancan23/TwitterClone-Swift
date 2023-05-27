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
    
    
}

