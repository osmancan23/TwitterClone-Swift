//
//  UserModel.swift
//  TwitterClone
//
//  Created by Osmancan Akagündüz on 27.05.2023.
//

import Foundation
import Firebase

struct UserModel: Codable {
    let id: String
    var displayName: String = ""
    var username: String = ""
    var followersCount: Double = 0
    var followingCount: Double = 0
    var createdOn: Date = Date()
    var bio: String = ""
    var avatarPath: String = ""
    var isUserOnboarded: Bool = false
    
    
    init(from user: User) {
        self.id = user.uid
    }
    
    

}


