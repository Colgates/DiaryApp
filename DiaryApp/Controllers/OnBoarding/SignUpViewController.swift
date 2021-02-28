//
//  SignUpViewController.swift
//  DiaryApp
//
//  Created by Evgenii Kolgin on 16.11.2020.
//

import UIKit
import SafariServices

class SignUpViewController: UIViewController {
    
    private let hiImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "hi")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let emailField: UITextField = {
        let textfield = UITextField()
        let bluePlaceholderText = NSAttributedString(string: "Email...",
                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "color1") ?? .black])
        textfield.attributedPlaceholder = bluePlaceholderText
        textfield.textColor = UIColor(named: "color1")
        textfield.leftViewMode = .always
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textfield.returnKeyType = .next
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        textfield.layer.masksToBounds = true
        textfield.layer.cornerRadius = 10.0
        textfield.layer.borderWidth = 3.0
        textfield.layer.borderColor = UIColor(named: "color1")?.cgColor
        textfield.keyboardType = .emailAddress
        return textfield
    }()
    
    private let passwordField: UITextField = {
        let textfield = UITextField()
        let bluePlaceholderText = NSAttributedString(string: "Password...",
                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "color1") ?? .black])
        textfield.attributedPlaceholder = bluePlaceholderText
        textfield.textColor = UIColor(named: "color1")
        textfield.leftViewMode = .always
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textfield.isSecureTextEntry = true
        textfield.returnKeyType = .continue
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        textfield.layer.masksToBounds = true
        textfield.layer.cornerRadius = 10.0
        textfield.layer.borderWidth = 3.0
        textfield.layer.borderColor = UIColor(named: "color1")?.cgColor
        return textfield
    }()
    
    private let signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("SIGN UP", for: .normal)
        button.layer.cornerRadius = 10.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowOpacity = 0.5
        button.backgroundColor = UIColor(named: "color1")
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        signupButton.addTarget(self, action: #selector(didTapSignupButton), for: .touchUpInside)
        
        emailField.delegate = self
        passwordField.delegate = self
        
        title = "Create an Acoount"
        view.backgroundColor = UIColor(named: "color")
        addSubviews()
    }
    
    @objc private func didTapSignupButton() {
            
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        
        AuthManager.shared.registerNewUser(email: email, password: password) { (registered) in
            DispatchQueue.main.async {
                if registered {
                    // good to go
                    let vc = HomeViewController()
                    self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
                    
                } else {
                    // failed
                    let actionSheet = UIAlertController(title: "Error", message: "email exists", preferredStyle: .actionSheet)
                    actionSheet.addAction(UIAlertAction(title: "Forgot password?", style: .default, handler: nil))
                    actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    self.present(actionSheet, animated: true, completion: nil)
                }
            }
        }
    }
    
    private func addSubviews() {
        view.addSubview(hiImage)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signupButton)
    }
    
    override func viewDidLayoutSubviews() {
        
        hiImage.frame = CGRect(x: 20, y: view.safeAreaInsets.top + view.height / 9, width: view.width / 2, height: view.width / 2)
        
        emailField.frame = CGRect(
            x: 20,
            y: view.frame.size.width - 40,
            width: view.frame.size.width - 40,
            height: 50.0)
        
        passwordField.frame = CGRect(
            x: 20,
            y: emailField.frame.origin.y + emailField.frame.size.height + 10,
            width: view.frame.size.width - 40,
            height: 50.0)
        
        signupButton.frame = CGRect(
            x: 20,
            y: passwordField.frame.origin.y + passwordField.frame.size.height + 10,
            width: view.frame.size.width - 40,
            height: 50.0)
    }

}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else {
            didTapSignupButton()
        }
        return true
    }
}
