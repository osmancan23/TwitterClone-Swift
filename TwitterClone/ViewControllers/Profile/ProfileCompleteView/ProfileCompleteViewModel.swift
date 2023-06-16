//
//  ProfileCompleteViewModel.swift
//  TwitterClone
//
//  Created by Osmancan Akagündüz on 29.05.2023.
//

import Foundation
import UIKit
import FirebaseStorage
import Combine
import FirebaseAuth

final class ProfileCompleteViewModel : ObservableObject {
    private var subscriptions: Set<AnyCancellable> = []

    @Published var displayName : String?
    @Published var userName : String?
    @Published var bioText : String?
    @Published var avatarPath : String?
    @Published var avatarImage : UIImage?
    @Published var isValidate : Bool = false
    @Published var error: String = ""
    @Published var isCompleteOnboard : Bool = false

    func validateValues()  {
        guard let displayName = displayName , displayName.count>2, let userName = userName , userName.count>2, let bioText = bioText, bioText.count>2, avatarImage != nil else {
            
            isValidate = false
            return
        }
        
        isValidate = true
    }
    
    
    func uploadAvatar() {
        
        let randomID = UUID().uuidString
            guard let imageData = avatarImage?.jpegData(compressionQuality: 0.5) else { return }
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpeg"
            
            StorageManager.shared.uploadProfilePhoto(with: randomID, image: imageData, metaData: metaData)
                .flatMap({ metaData in
                    StorageManager.shared.getDownloadURL(for: metaData.path)
                })
                .sink { [weak self] completion in
                    switch completion {
                    case .failure(let error):
                        print(error.localizedDescription)
                        self?.error = error.localizedDescription
                    case .finished:

                        print("girdi")
                        self?.updateProfile()
                    }
                } receiveValue: { [weak self] url in
                    self?.avatarPath = url.absoluteString
                }
                .store(in: &subscriptions)
        }
    
    
   private func updateProfile()  {
    

        guard let userName , let displayName, let bioText , let avatarPath , let id = Auth.auth().currentUser?.uid else {
            self.isCompleteOnboard = false
            return
        }
       print(id);
        let data : [String : Any] = [
            "bio" : bioText,
            "username": userName,
            "displayName" : displayName,
            "avatarPath" : avatarPath,
            "isUserOnboarded" : true
        ]
        
        DatabaseManager.instance.updateUserProfile(data: data, id: id).sink {[weak self] completion in
            
            
            if case .failure(let error) = completion {
                print(error.localizedDescription)
                self?.error = error.localizedDescription
            }
        } receiveValue: { value in
            print(value)
            self.isCompleteOnboard = value
        }.store(in: &subscriptions)


    }
}
