//
//  RegisterViewController.swift
//  TwitterClone
//
//  Created by Osmancan Akagündüz on 24.05.2023.
//

import UIKit

class RegisterViewController: UIViewController {

    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Create your account"
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
       
       
       private let registerButton: UIButton = {
           let button = UIButton(type: .system)
           button.translatesAutoresizingMaskIntoConstraints = false
           button.setTitle("Create account", for: .normal)
           button.tintColor = .white
           button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
           button.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
           button.layer.masksToBounds = true
           button.layer.cornerRadius = 25
           button.isEnabled = false
           return button
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        view.addSubview(titleLabel)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
        
        
        configureConstraints()
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
                  registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                  registerButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
                  registerButton.widthAnchor.constraint(equalToConstant: 180),
                  registerButton.heightAnchor.constraint(equalToConstant: 50)
              ]
        
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(emailFieldConstraints)
        NSLayoutConstraint.activate(passwordFieldConstraints)
        NSLayoutConstraint.activate(registerButtonConstraints)

    }

}
