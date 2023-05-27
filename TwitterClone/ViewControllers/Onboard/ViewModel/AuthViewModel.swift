//
//  RegisterViewModel.swift
//  TwitterClone
//
//  Created by Osmancan Akagündüz on 25.05.2023.
//

import Foundation
import Firebase
import Combine
 class AuthViewModel : ObservableObject {
    @Published var email : String?
    @Published var password : String?
    @Published var isValidate : Bool = false
    @Published var user: User?
    @Published var error: String?
         
         
    private var subscriptions: Set<AnyCancellable> = []
     
     func validateFormValue()  {
         guard let email = email , let password = password else {
             isValidate = false
             return
         }
         
         isValidate = isValidEmail(email) && password.count >= 8
     }
     
     
     func isValidEmail(_ email: String) -> Bool {
             let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

             let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
             return emailPred.evaluate(with: email)
         }
    
    @objc func register() {
         guard let email = email,
               let password = password else { return }
         AuthManager.instance.register(with: email, password: password)
             .handleEvents(receiveOutput: { [weak self] user in
                 self?.user = user
             })
             .sink { [weak self] completion in
                 if case .failure(let error) = completion {
                     self?.error = error.localizedDescription
                 }
                 
             } receiveValue: { [weak self] user in
                 self?.saveUser()
             }
             .store(in: &subscriptions)

     }
     
     func saveUser()   {
         DatabaseManager.instance.createUserProfile(user: self.user!).sink { completion in
             if case .failure(let error) = completion {
                    self.error = error.localizedDescription
            }
         } receiveValue: { value in
             print("Adding user record to database: \(value)")

         }.store(in: &subscriptions)

     }

     @objc func login() {
          guard let email = email,
                let password = password else { return }
          AuthManager.instance.login(with: email, password: password)
              
              .sink { [weak self] completion in
                  if case .failure(let error) = completion {
                      self?.error = error.localizedDescription
                  }
                  
              } receiveValue: { [weak self] user in
                  self?.user = user
              }
              .store(in: &subscriptions)

      }
     
    

}
