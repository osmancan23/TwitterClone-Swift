//
//  TweetComposeViewController.swift
//  TwitterClone
//
//  Created by Osmancan Akagündüz on 6.06.2023.
//

import UIKit
import Combine
import ProgressHUD
class TweetComposeViewController: UIViewController {

    let viewModel = TweetComposeViewModel()
    
    var subcriptions : Set<AnyCancellable> = []
    private lazy var tweetButton : UIButton  = {
         let button = UIButton(type: .system, primaryAction: UIAction  {
             [weak self] _ in
             ProgressHUD.show()
             self?.viewModel.sendTweet()
         })
         button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Share", for: .normal)
         button.tintColor = .white
         button.backgroundColor = .tweeterColor
         button.cornerRadius = 30
         button.clipsToBounds = false
        button.isEnabled = false
         return button
     }()
     
    let contentTextView: UITextView = {
          
           let textView = UITextView()
           textView.translatesAutoresizingMaskIntoConstraints = false
           textView.backgroundColor = .systemBackground
           textView.layer.masksToBounds = true
           textView.layer.cornerRadius = 8
           textView.textContainerInset = .init(top: 15, left: 15, bottom: 15, right: 15)
           textView.text = "What's happening"
           textView.textColor = .gray
           textView.font = .systemFont(ofSize: 16)
           return textView
       }()
    
    func configureConstraints()  {
        let tweetButtonConstraints = [
            tweetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tweetButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            tweetButton.heightAnchor.constraint(equalToConstant: 60),
            tweetButton.widthAnchor.constraint(equalToConstant: 200),

        ]
        
        let contentTextConstraints = [
            contentTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            contentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            contentTextView.bottomAnchor.constraint(equalTo: tweetButton.topAnchor, constant: -10)

        ]
        NSLayoutConstraint.activate(tweetButtonConstraints)
        NSLayoutConstraint.activate(contentTextConstraints)
    }
    
    func bindViews()  {
        viewModel.$isValidate.sink { [weak self] value in
            self?.tweetButton.isEnabled = value
        }.store(in: &subcriptions)
        
        viewModel.$isCompleted.sink { value in
            
            if value {
                ProgressHUD.showSucceed()
                self.dismiss(animated: true)
            }else{
                ProgressHUD.showError()
            }
            
        }.store(in: &subcriptions)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tweetButton)
        view.addSubview(contentTextView)
        contentTextView.delegate = self
        view.backgroundColor = .systemBackground
        title = "Tweet"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(onTapBack))
        
        configureConstraints()
        bindViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchUser()
    }
    
    @objc func onTapBack()  {
        self.dismiss(animated: true)
    }

  

}

extension TweetComposeViewController : UITextViewDelegate {
    
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .gray {
            textView.textColor = .label
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.isEmpty {
            textView.text = "What's happening"
            textView.textColor = .gray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        viewModel.tweetContent = textView.text
        viewModel.validate()
    }
}
