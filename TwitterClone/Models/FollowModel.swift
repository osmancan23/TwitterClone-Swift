//
//  FollowModel.swift
//  TwitterClone
//
//  Created by Osmancan Akagündüz on 10.06.2023.
//

import Foundation

struct FollowModel : Codable{
    let id = UUID().uuidString
    let follower : String
    let following : String
    let date : Date = Date()
    
}
