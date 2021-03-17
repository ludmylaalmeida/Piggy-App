//
//  LoginViewController.swift
//  Piggy
//
//  Created by ludmyla almeida on 3/10/21.
//  Copyright © 2021 ludmyla almeida. All rights reserved.
//
import UIKit
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import GoogleSignIn

class LoginViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to Piggy!"
        label.font = UIFont(name: "Helvetica-Bold", size: 24 )
        return label
    }()
    
    private let subtitleField: UITextView = {
        let label = UITextView()
        label.text = "Login to continue using your account"
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
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.backgroundColor = UIColor.piggyPink
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Don’t have an account? Register", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        
        emailField.delegate = self
        passwordField.delegate = self
        addSubViews()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //assign frames
        welcomeLabel.frame = CGRect(x:25, y: view.safeAreaInsets.top + 100, width: view.width, height: 30)
        
        subtitleField.frame = CGRect(x:25, y: welcomeLabel.bottom + 10, width: view.width, height: 30)
        
        emailField.frame = CGRect(x:25, y: subtitleField.bottom + 50, width: view.width - 50, height: 40)
        
        passwordField.frame = CGRect(x:25, y: emailField.bottom + 50, width: view.width - 50, height: 40)
        
        loginButton.frame = CGRect(x:25, y: passwordField.bottom + 60, width: view.width - 50, height: 50)
        
        createAccountButton.frame = CGRect(x: 25, y: loginButton.bottom + 20, width: view.width - 50, height: 50)
        
    }
    
    private func addSubViews(){
        view.addSubview(welcomeLabel)
        view.addSubview(subtitleField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(createAccountButton)
    }
    
    @objc private func didTapLoginButton(){
        
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text, !email.isEmpty,
            let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
                return
        }
        
        //login functionality
        
        AuthManager.shared.loginUser(email: emailField.text!, password: passwordField.text!) { success in
            DispatchQueue.main.async {
                if success {
                    //user log in
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
    
    @objc private func didTapCreateAccountButton(){
        //let vc = RegistrationViewController()
//        LoginViewController().present(vc, animated: true, completion: nil)
//        var topMostViewController = UIApplication.shared.keyWindow?.rootViewController

//        present(vc, animated: true)
        
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField{
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            didTapLoginButton()
        }
        
        return true
    }
}

//struct LabelledDivider: View {
//
//    let label: String
//    let horizontalPadding: CGFloat
//    let color: UIColor
//
//    init(label: String, horizontalPadding: CGFloat = 20, color: Color = .gray) {
//        self.label = label
//        self.horizontalPadding = horizontalPadding
//        self.color = .gray
//    }
//
//    var body: some View {
//        HStack {
//            line
//            Text(label).foregroundColor(color)
//            line
//        }
//    }
//
//    var line: some View {
//        VStack { Divider().background(color) }.padding(horizontalPadding)
//    }
//}
