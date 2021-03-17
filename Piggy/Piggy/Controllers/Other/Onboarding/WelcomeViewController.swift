//
//  WelcomeViewController.swift
//  Piggy
//
//  Created by ludmyla almeida on 3/10/21.
//  Copyright © 2021 ludmyla almeida. All rights reserved.
//

import UIKit
import SafariServices

class WelcomeViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "pig"))
        return image
    }()

    private let textView: UILabel = {
        let label = UILabel()
        label.text = "Track your investments and connect with others."
        label.font = UIFont(name: "Helvetica-Bold", size: 21 )
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.backgroundColor = UIColor.piggyPink
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.backgroundColor = .white
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        button.setTitleColor(.label, for: .normal)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms and Conditions", for: .normal)
        button.backgroundColor = .white
        button.layer.masksToBounds = true
        button.setTitleColor(.label, for: .normal)
        return button
    }()
       
    private let privacyButton: UIButton = {
        return UIButton()
    }()
    
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
        
        imageView.frame = CGRect(x:0, y: view.safeAreaInsets.top + 100, width: view.width, height: view.height/2.2)
        
        textView.frame = CGRect(x:0, y: imageView.bottom + 10, width: view.width, height: 50)
        
        loginButton.frame = CGRect(x:25, y: textView.bottom + 30, width: view.width - 50, height: 50)
        
        createAccountButton.frame = CGRect(x:25, y: textView.bottom + 100, width: view.width - 50, height: 50)
        
        termsButton.frame = CGRect(x:25, y: createAccountButton.bottom + 10, width: view.width - 50, height: 50)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        view.backgroundColor = .systemBackground
        
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchDown)
        
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
    }
    
    private func addSubViews(){
        view.addSubview(textView)
        view.addSubview(loginButton)
        view.addSubview(createAccountButton)
        view.addSubview(imageView)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
    }
    
    @objc private func didTapLoginButton(){
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let loginViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
        print("Could'nt find the view controller")
        return
        }
        present(loginViewController, animated: true, completion: nil)
        
    }
    
    @objc private func didTapCreateAccountButton(){
        let vc = RegistrationViewController()
        vc.title = "Registration"
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    @objc private func didTermsButton(){
    }
    
    @objc private func didPrivacyButton(){
    }
}
