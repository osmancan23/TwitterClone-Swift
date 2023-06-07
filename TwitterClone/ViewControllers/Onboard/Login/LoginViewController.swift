//
//  LoginViewController.swift
//  TwitterClone
//
//  Created by Osmancan Akagündüz on 27.05.2023.
//

import UIKit
import Combine

class LoginViewController: UIViewController {
    private var viewModel = AuthViewModel()
    private var subscriptions: Set<AnyCancellable> = []

    func presentAlert(message:String)  {
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
   }
    
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Login your account"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        
        return label
    }()
    
    let emailField : UITextField = {
        let textField = UITextField()
                textField.translatesAutoresizingMaskIntoConstraints = false
                textField.keyboardType = .emailAddress
                textField.attributedPlaceholder = NSAttributedString(
                    string: "Email",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
                )
                return textField
    }()
    
    
    private let passwordField: UITextField = {
           let textField = UITextField()
           textField.translatesAutoresizingMaskIntoConstraints = false
           textField.attributedPlaceholder = NSAttributedString(
               string: "Password",
               attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
           )
           textField.isSecureTextEntry = true
           return textField
       }()
       
       
       private let loginButton: UIButton = {
           let button = UIButton(type: .system)
           button.translatesAutoresizingMaskIntoConstraints = false
           button.setTitle("Login", for: .normal)
           button.tintColor = .white
           button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
           button.backgroundColor = .tweeterColor
           button.layer.masksToBounds = true
           button.layer.cornerRadius = 25
           button.isEnabled = false
           
           return button
       }()
    
    @objc func didChangeEmailField()  {
        viewModel.email = emailField.text
        viewModel.validateFormValue()
    }
    
   @objc func didChangePasswordField()  {
       viewModel.password = passwordField.text
       viewModel.validateFormValue()
    }
    
    func bindViewModel()  {
        emailField.addTarget(self, action: #selector(didChangeEmailField), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(didChangePasswordField), for: .editingChanged)
        
        
        
        viewModel.$isValidate.sink { [weak self] value in
            self!.loginButton.isEnabled = value
        }.store(in: &subscriptions)
        
        viewModel.$user.sink { [weak self] user in
                   guard user != nil else { return }
                   guard let vc = self?.navigationController?.viewControllers.first as? OnboardViewController else { return }
                   vc.dismiss(animated: true)
               }
               .store(in: &subscriptions)
               
               
               viewModel.$error.sink { [weak self] errorString in
                   guard let error = errorString else { return }
                   self?.presentAlert(message: error.localizedCapitalized)
                
               }
               .store(in: &subscriptions)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        view.addSubview(titleLabel)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        
        loginButton.addTarget(self, action: #selector(onTapLogin), for: .touchUpInside)
        
        configureConstraints()
        
        bindViewModel()
    }
    
   @objc private func onTapLogin()  {
        viewModel.login()
    }

    func configureConstraints()  {
        
        let titleLabelConstraints = [
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
        ]
        
        let emailFieldConstraints = [
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            emailField.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
            emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailField.heightAnchor.constraint(equalToConstant: 60)

        ]
        
        let passwordFieldConstraints = [
                  passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                  passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 15),
                  passwordField.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
                  passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                  passwordField.heightAnchor.constraint(equalToConstant: 60)
              ]
              
              
              let registerButtonConstraints = [
                  loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                  loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
                  loginButton.widthAnchor.constraint(equalToConstant: 180),
                  loginButton.heightAnchor.constraint(equalToConstant: 50)
              ]
        
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(emailFieldConstraints)
        NSLayoutConstraint.activate(passwordFieldConstraints)
        NSLayoutConstraint.activate(registerButtonConstraints)

    }

   

}
