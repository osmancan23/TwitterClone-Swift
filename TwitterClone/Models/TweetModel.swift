//
//  TweeterUserModel.swift
//  TwitterClone
//
//  Created by Osmancan Akagündüz on 6.06.2023.
//

import Foundation

struct TweetModel : Codable {
    let id = UUID().uuidString
    let author: UserModel
    let authorId: String
    let content: String
    let likeCount: Int
    let likers: [String]
    let isReply: Bool
    let parentReference: String?
    var createdOn: Date = Date()

}
