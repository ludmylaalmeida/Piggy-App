//
//  RegistrationViewController.swift
//  Piggy
//
//  Created by ludmyla almeida on 3/10/21.
//  Copyright © 2021 ludmyla almeida. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields

class RegistrationViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let createAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Create your account"
        label.font = UIFont(name: "Helvetica-Bold", size: 24 )
        return label
    }()
    
    private let subtitleField: UITextView = {
        let label = UITextView()
        label.text = "Fill in the required details and click Continue."
        label.font = UIFont(name: "Helvetica", size: 16 )
        return label
    }()
    
    private let emailField: MDCFilledTextField = {
        let field = MDCFilledTextField()
        field.label.text = "Email"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.tintColor = .black
        field.leadingView = UIImageView(image: UIImage(named: "email"))
        field.leadingViewMode = .always
        field.setFilledBackgroundColor(.white, for: MDCTextControlState.editing)
        field.setFilledBackgroundColor(.white, for: MDCTextControlState.normal)
        return field
    }()
    
    private let passwordField: MDCFilledTextField = {
        let field = MDCFilledTextField()
        field.isSecureTextEntry = true
        field.label.text = "Password"
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.tintColor = .black
        field.leadingView = UIImageView(image: UIImage(named: "password"))
        field.leadingViewMode = .always
        field.trailingView = UIImageView(image: UIImage(named: "password"))
        field.trailingViewMode = .always
        field.setFilledBackgroundColor(.white, for: MDCTextControlState.normal)
        field.setFilledBackgroundColor(.white, for: MDCTextControlState.editing)
        return field
    }()
    
    private let confirmPasswordField: MDCFilledTextField = {
        let field = MDCFilledTextField()
        field.isSecureTextEntry = true
        field.label.text = "Confirm Password"
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.tintColor = .black
        field.leadingView = UIImageView(image: UIImage(named: "password"))
        field.leadingViewMode = .always
        field.trailingView = UIImageView(image: UIImage(named: "password"))
        field.trailingViewMode = .always
        field.setFilledBackgroundColor(.white, for: MDCTextControlState.normal)
        field.setFilledBackgroundColor(.white, for: MDCTextControlState.editing)
        return field
    }()
    
    private let continueButton: UIButton = {
           let button = UIButton()
           button.setTitle("Continue", for: .normal)
           button.backgroundColor = UIColor.piggyPink
           button.layer.masksToBounds = true
           button.layer.cornerRadius = Constants.cornerRadius
           return button
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        continueButton.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)
        
        emailField.delegate = self
        passwordField.delegate = self
        confirmPasswordField.delegate = self
        addSubViews()
        view.backgroundColor = .systemBackground
    }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //assign frames
        createAccountLabel.frame = CGRect(x:25, y: view.safeAreaInsets.top + 100, width: view.width, height: 30)
        
        subtitleField.frame = CGRect(x:25, y: createAccountLabel.bottom + 10, width: view.width, height: 30)
        
        emailField.frame = CGRect(x:25, y: subtitleField.bottom + 40, width: view.width - 50, height: 40)
        
        passwordField.frame = CGRect(x:25, y: emailField.bottom + 40, width: view.width - 50, height: 40)
        
        confirmPasswordField.frame = CGRect(x:25, y: passwordField.bottom + 40, width: view.width - 50, height: 40)
        
        continueButton.frame = CGRect(x:25, y: confirmPasswordField.bottom + 40, width: view.width - 50, height: 50)
        
    }
    
    private func addSubViews(){
        view.addSubview(createAccountLabel)
        view.addSubview(subtitleField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(confirmPasswordField)
        view.addSubview(continueButton)
    }
    
    @objc private func didTapContinueButton(){
        
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        confirmPasswordField.resignFirstResponder()
        
        guard let email = emailField.text, !email.isEmpty,
            let password = passwordField.text, !password.isEmpty, password.count >= 8,
            let confirmPassword = confirmPasswordField.text, !confirmPassword.isEmpty, confirmPassword == password, password.count >= 8 else {
                
                return
        }
            
        AuthManager.shared.registerNewUser(email: emailField.text!, password: passwordField.text!) { registered in
            DispatchQueue.main.async {
                if registered {
                    // good to go
                    self.dismiss(animated: true, completion: nil)
                } else {
                    //error occured
                    let alert = UIAlertController(title: "Log in error", message: "We were unable to log you in.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
        }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField{
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            confirmPasswordField.becomeFirstResponder()
        } else {
            didTapContinueButton()
        }

        return true
    }
}
