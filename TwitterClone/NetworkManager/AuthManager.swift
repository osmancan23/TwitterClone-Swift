//
//  AuthManager.swift
//  TwitterClone
//
//  Created by Osmancan Akagündüz on 25.05.2023.
//

import Foundation
import Firebase
import FirebaseAuthCombineSwift
import Combine

class AuthManager {
    static let instance  = AuthManager()
    
       func register(with email: String, password: String) -> AnyPublisher<User, Error> {
           return Future<User, Error> { promise in
                   Auth.auth().createUser(withEmail: email, password: password) { result, error in
                       if let error = error {
                           promise(.failure(error))
                       } else if let user = result?.user {
                           promise(.success(user))
                       } else {
                           let error = NSError(domain: "YourDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "User not found"])
                           promise(.failure(error))
                       }
                   }
               }
           
           
           
           
           
               .eraseToAnyPublisher()
       }
       
       func login(with email: String, password: String) -> AnyPublisher<User, Error> {
           return Future<User,Error > { promise in
               Auth.auth().signIn(withEmail: email, password: password){ result, error in
                   if let error = error {
                       promise(.failure(error))
                   } else if let user = result?.user {
                       promise(.success(user))
                   } else {
                       let error = NSError(domain: "YourDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "User not found"])
                       promise(.failure(error))
                   }
                   
                   
               }
           }.eraseToAnyPublisher()
       }
}
