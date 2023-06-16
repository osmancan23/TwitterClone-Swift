//
//  ProfileCompleteViewController.swift
//  TwitterClone
//
//  Created by Osmancan Akagündüz on 27.05.2023.
//

import UIKit
import PhotosUI
import Combine
import ProgressHUD
class ProfileCompleteViewController: UIViewController {

    let viewModel = ProfileCompleteViewModel()
    
    var subscriptions :Set<AnyCancellable> = []
    
    let scrollView : UIScrollView = {
       let scrollView = UIScrollView()
       scrollView.translatesAutoresizingMaskIntoConstraints = false
       scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .onDrag

       return scrollView
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Complete Your Profile"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .label
        
        return label
    }()
    
    let avatarImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        let image = UIImage(systemName: "camera.fill")
        imageView.image = image
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 60
        imageView.tintColor = .gray
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let displayNameField : UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .default
        textField.backgroundColor =  .secondarySystemFill
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 8
        textField.attributedPlaceholder = NSAttributedString(string: "Display Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        return textField
    }()
    
    
    let userNameField : UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .default
        textField.backgroundColor =  .secondarySystemFill
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 8
        textField.attributedPlaceholder = NSAttributedString(string: "User Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        return textField
    }()
    
     let bioTextView: UITextView = {
           
            let textView = UITextView()
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.backgroundColor = .secondarySystemFill
            textView.layer.masksToBounds = true
            textView.layer.cornerRadius = 8
            textView.textContainerInset = .init(top: 15, left: 15, bottom: 15, right: 15)
            textView.text = "Tell the world about yourself"
            textView.textColor = .gray
            textView.font = .systemFont(ofSize: 16)
            return textView
        }()
    
    let saveButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .tweeterColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25
        button.isEnabled = false

        return button
    }()
    
    func configureConstraints()  {
        let scrollViewConstraints = [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

        ]
        
        let titleLabelConstraints = [
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
        ]
        
        let avatarImageConstraints = [
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 120),
            avatarImageView.widthAnchor.constraint(equalToConstant: 120),
            avatarImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
        ]
        
        let displayNameFieldConstraints = [
            displayNameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            displayNameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            displayNameField.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 40),
            displayNameField.heightAnchor.constraint(equalToConstant: 50),
        ]
        
        let userNameFieldConstraints = [
            userNameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userNameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            userNameField.topAnchor.constraint(equalTo: displayNameField.bottomAnchor, constant: 20),
            userNameField.heightAnchor.constraint(equalToConstant: 50),
        ]
        
        let bioTextViewConstraints = [
            bioTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bioTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bioTextView.topAnchor.constraint(equalTo: userNameField.bottomAnchor, constant: 20),
            bioTextView.heightAnchor.constraint(equalToConstant: 100),
        ]
        
        let saveButtonConstraints = [
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.topAnchor.constraint(equalTo: bioTextView.bottomAnchor, constant: 200),
            saveButton.heightAnchor.constraint(equalToConstant: 60),
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(avatarImageConstraints)
        NSLayoutConstraint.activate(displayNameFieldConstraints)
        NSLayoutConstraint.activate(userNameFieldConstraints)
        NSLayoutConstraint.activate(bioTextViewConstraints)
        NSLayoutConstraint.activate(saveButtonConstraints)

    }
    
  @objc private func changedDisplayName() {
      viewModel.displayName = displayNameField.text
      viewModel.validateValues()
  }
    
    @objc private func changedUserName() {
        viewModel.userName = userNameField.text
        viewModel.validateValues()
      }
    
    func bindViews()  {
        displayNameField.addTarget(self, action: #selector(changedDisplayName), for: .editingChanged)
        userNameField.addTarget(self, action: #selector(changedUserName), for: .editingChanged)
        
        viewModel.$isValidate.sink { [weak self] isSuccess in
            self?.saveButton.isEnabled = isSuccess
        }.store(in: &subscriptions)
        
        
        viewModel.$isCompleteOnboard.sink { isSuccess in
            
            if isSuccess {
                ProgressHUD.dismiss()

                self.dismiss(animated: true)

            }
            else {
                ProgressHUD.showError()
            }
        }.store(in: &subscriptions )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        isModalInPresentation = true
        displayNameField.delegate = self
        userNameField.delegate = self
        bioTextView.delegate = self
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToDismiss)))
        view.addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(avatarImageView)
        scrollView.addSubview(displayNameField)
        scrollView.addSubview(userNameField)
        scrollView.addSubview(bioTextView)
        scrollView.addSubview(saveButton)
        
        configureConstraints()
        avatarImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToUpload)))
        saveButton.addTarget(self, action: #selector(didTapSubmit), for: .touchUpInside)

        bindViews()
    }
    
    @objc private func didTapSubmit() {
        ProgressHUD.show()
        viewModel.uploadAvatar()
    }
    
    @objc private func didTapToUpload() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
            
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc private func didTapToDismiss() {
            view.endEditing(true)
        }

  

}

extension ProfileCompleteViewController: UITextViewDelegate, UITextFieldDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        scrollView.setContentOffset(CGPoint(x: 0, y: textView.frame.origin.y - 100), animated: true)
        if textView.textColor == .gray {
            textView.textColor = .label
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        
        if textView.text.isEmpty {
            textView.text = "Tell the world about yourself"
            textView.textColor = .gray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        viewModel.bioText = bioTextView.text
        viewModel.validateValues()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
            scrollView.setContentOffset(CGPoint(x: 0, y: textField.frame.origin.y - 100), animated: true)
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
}
extension ProfileCompleteViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        self?.avatarImageView.image = image
                        self?.viewModel.avatarImage = image
                        self?.viewModel.validateValues()

                    }
                }
            }
        }
    }
    
    
}
