//
//  ProfileHeaderViewModel.swift
//  TwitterClone
//
//  Created by Osmancan Akagündüz on 10.06.2023.
//

import Foundation
import Combine
import Firebase
class ProfileHeaderViewModel : ObservableObject {
    @Published var error : String?
    @Published var isFollowing: Bool = false
    @Published var hasUpdated: Bool = false
    @Published var followerCount: Int = 0
    @Published var followingCount: Int = 0

    var subscriptions : Set<AnyCancellable> = []
    
    
    func checkFollowStatus(followingId:String)  {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let followModel = FollowModel(follower: userId, following: followingId)
        
        DatabaseManager.instance.checkFollowStatus(follow: followModel).sink { completion in
            if case .failure(let error) = completion {
                self.error = error.localizedDescription
            }
        } receiveValue: { res in
            self.isFollowing = res
        }.store(in: &subscriptions)

    }
    
    func followOrUnfollow(followingId:String)  {
        guard let id = Auth.auth().currentUser?.uid else {
            return
        }
        let followModel = FollowModel(follower: followingId, following: id)
       
        if(self.isFollowing){
            DatabaseManager.instance.unFollowUser(follow: followModel).sink { completion in
                if case .failure(let error) = completion {
                    self.error = error.localizedDescription
                }
            } receiveValue: { value in
                self.hasUpdated = value
            }.store(in: &subscriptions)

        }
        else{
            DatabaseManager.instance.followUser(follow: followModel).sink { completion in
                if case .failure(let error) = completion {
                    self.error = error.localizedDescription
                }
            } receiveValue: { value in
                print(value)
                self.hasUpdated = value
            }.store(in: &subscriptions)
        }
    }
    
    func fetchFollowingCount(userId: String)  {
        DatabaseManager.instance.fetchFollowingCount(userId: userId).sink { completion in
            if case .failure(let error ) = completion {
                print(error.localizedDescription)
            }
        } receiveValue: { value in
            self.followingCount = value
        }.store(in: &subscriptions)
    }
    
    func fetchFollowerCount(userId: String)  {
        DatabaseManager.instance.fetchFollowerCount(userId: userId).sink { completion in
            if case .failure(let error ) = completion {
                print(error.localizedDescription)
            }
        } receiveValue: { value in
            self.followerCount = value
        }.store(in: &subscriptions)
    }
    
    
    
}
