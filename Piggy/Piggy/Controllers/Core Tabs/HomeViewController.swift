//
//  HomeViewController.swift
//  Piggy
//
//  Created by ludmyla almeida on 3/1/21.
//  Copyright © 2021 ludmyla almeida. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Do any additional stuff
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        handleNotAuthenticated()
    }
    
    private func handleNotAuthenticated() {
        //Check Authentication status
        if Auth.auth().currentUser == nil {
            //Show Welcome page
            let welcomeVC = WelcomeViewController()
            welcomeVC.modalPresentationStyle = .fullScreen
            present(welcomeVC, animated: false)
            
            //Show log in
//            let loginVC = LoginViewController()
//            loginVC.modalPresentationStyle = .fullScreen
//            present(loginVC, animated: false)
            
        }
    }
}
