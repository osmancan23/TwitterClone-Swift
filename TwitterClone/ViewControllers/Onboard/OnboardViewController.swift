//
//  OnboardViewController.swift
//  TwitterClone
//
//  Created by Osmancan Akagündüz on 23.05.2023.
//

import UIKit

class OnboardViewController: UIViewController {

    
    let welcomeLabel : UILabel = {
        let label = UILabel()
              label.numberOfLines = 0
              label.text = "See what's happening in the world right now."
              label.font = .systemFont(ofSize: 32, weight: .heavy)
              label.translatesAutoresizingMaskIntoConstraints = false
              label.textAlignment = .center
              label.textColor = .label
              return label
    }()
    
    let registerButton : UIButton = {
        let button = UIButton(type: .system)
               button.translatesAutoresizingMaskIntoConstraints = false
               button.setTitle("Create account", for: .normal)
               button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
               button.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
               button.layer.masksToBounds = true
               button.tintColor = .white
               button.layer.cornerRadius = 30
        return button
    }()
    
    let promptLabel : UILabel = {
        let label = UILabel()
        label.text = "Have an account already?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.tintColor = .label
        return label
    }()
    
    let loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.tintColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func configureConstraints()  {
        let welcomeLabelConstraints = [
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        
        let registerConstraints = [
            registerButton.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor , constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: welcomeLabel.trailingAnchor,constant: -20),
            registerButton.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor,constant: 10),
            registerButton.heightAnchor.constraint(equalToConstant: 60)

        ]
        
        let promptLabelConstraints = [
            promptLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            promptLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),

        ]
        
        let loginButtonConstraints = [
            loginButton.centerYAnchor.constraint(equalTo: promptLabel.centerYAnchor),
                        loginButton.leadingAnchor.constraint(equalTo: promptLabel.trailingAnchor, constant: 10)
        ]
        
        NSLayoutConstraint.activate(welcomeLabelConstraints)
        NSLayoutConstraint.activate(registerConstraints)
        NSLayoutConstraint.activate(promptLabelConstraints)
        NSLayoutConstraint.activate(loginButtonConstraints)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(welcomeLabel)
        view.addSubview(registerButton)
        view.addSubview(promptLabel)
        view.addSubview(loginButton)
        
        registerButton.addTarget(self, action: #selector(onTapRegister), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(onTapLogin), for: .touchUpInside)
        
        configureConstraints()

    }
    
   @objc func onTapRegister()  {
        let vc = RegisterViewController()
       
       navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func onTapLogin()  {
         print("register")
     }
    

}
