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
            return Auth.auth().createUser(withEmail: email, password: password)
                .map(\.user)
                .eraseToAnyPublisher()
        }
    
    
    func login(with email: String, password: String) -> AnyPublisher<User, Error> {
        return Auth.auth().signIn(withEmail: email, password: password)
            .map(\.user)
            .eraseToAnyPublisher()
    }
}
