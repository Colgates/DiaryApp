//
//  LoginViewController.swift
//  DiaryApp
//
//  Created by Evgenii Kolgin on 16.11.2020.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let line: UIView = {
        let line = UIView()
        line.backgroundColor = .white
        line.alpha = 0.5
        return line
    }()
    
    private let secondLine: UIView = {
        let line = UIView()
        line.backgroundColor = .white
        line.alpha = 0.5
        return line
    }()
    
    private let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "title")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let loginButton: HighlightedButton = {
        let button = HighlightedButton()
        button.setTitle("LOG IN", for: .normal)
        button.layer.cornerRadius = 10.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowOpacity = 0.5
        button.backgroundColor = .systemPink
        return button
    }()
    
    private let createButton: UIButton = {
        let button = UIButton()
        button.setTitle("New User? Create an Account", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let forgetPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot Password?", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let usernameTextfield: UITextField = {
        let textfield = UITextField()
        let redPlaceholderText = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textfield.attributedPlaceholder = redPlaceholderText
        textfield.returnKeyType = .next
        textfield.textColor = .lightGray
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        textfield.keyboardType = .emailAddress
        return textfield
    }()
    
    private let passwordTextfield: UITextField = {
        let textfield = UITextField()
        let redPlaceholderText = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textfield.attributedPlaceholder = redPlaceholderText
        textfield.returnKeyType = .done
        textfield.textColor = .lightGray
        textfield.isSecureTextEntry = true
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        return textfield
    }()
    
    private let usernameImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "envelope")
        imageView.tintColor = .white
        imageView.contentMode = .center
        return imageView
    }()
    
    private let passwordImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "lock")
        imageView.tintColor = .white
        imageView.contentMode = .center
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextfield.delegate = self
        passwordTextfield.delegate = self
        
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        createButton.addTarget(self, action: #selector(didTapCreateButton), for: .touchUpInside)
        
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        addSubviews()
    }
    
    @objc private func didTapLoginButton() {
        
        usernameTextfield.resignFirstResponder()
        passwordTextfield.resignFirstResponder()
        
        guard let usernameEmail = usernameTextfield.text, !usernameEmail.isEmpty,
              let password = passwordTextfield.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        // login functionality
        AuthManager.shared.loginUser(email: usernameEmail, password: password) { success in
            DispatchQueue.main.async {
                if success {
                    // user logged in
                    self.dismiss(animated: true, completion: nil)
                } else {
                    // error occurred
                    let alert = UIAlertController(title: "Log In Error", message: "We're unable to log you in.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc private func didTapCreateButton() {
        let vc = SignUpViewController()
        present(vc, animated: true, completion: nil)
    }
    
    private func addSubviews() {
        view.addSubview(usernameTextfield)
        view.addSubview(passwordTextfield)
        view.addSubview(usernameImage)
        view.addSubview(passwordImage)
        view.addSubview(loginButton)
        view.addSubview(createButton)
        view.addSubview(forgetPasswordButton)
        view.addSubview(logoImage)
        view.addSubview(line)
        view.addSubview(secondLine)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        logoImage.frame = CGRect(x: 20,
                                 y: view.height / 8,
                                 width: view.width - 40,
                                 height: view.width - 40)
        
        
        usernameImage.frame = CGRect(x: 40,
                                     y: view.height / 2,
                                     width: 30,
                                     height: 30)
        
        usernameTextfield.frame = CGRect(x: usernameImage.right,
                                         y: view.height / 2,
                                         width: view.width - 80 - usernameImage.width,
                                         height: 30)
        
        line.frame = CGRect(x: 40,
                            y: usernameImage.bottom,
                            width: view.width - 80,
                            height: 1)
        
        passwordImage.frame = CGRect(x: 40,
                                     y: line.bottom + 10,
                                     width: 30,
                                     height: 30)
        
        passwordTextfield.frame = CGRect(x: passwordImage.right,
                                         y: line.bottom + 10,
                                         width: view.width - 80 - passwordImage.width,
                                         height: 30)
        
        secondLine.frame = CGRect(x: 40,
                                  y: passwordImage.bottom,
                                  width: view.width - 80,
                                  height: 1)
        
        loginButton.frame = CGRect(x: 40,
                                   y: secondLine.bottom + 40,
                                   width: view.width - 80,
                                   height: 50)
        
        createButton.frame = CGRect(x: 40,
                                    y: loginButton.bottom + 10,
                                    width: view.width - 80,
                                    height: 30)
        
        forgetPasswordButton.frame = CGRect(x: 40,
                                            y: view.height - view.safeAreaInsets.bottom - 40,
                                            width: view.width - 80,
                                            height: 30)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextfield {
            passwordTextfield.becomeFirstResponder()
        } else {
            didTapLoginButton()
        }
        return true
    }
}
