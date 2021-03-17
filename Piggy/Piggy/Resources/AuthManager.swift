//
//  AuthManager.swift
//  Piggy
//
//  Created by ludmyla almeida on 3/10/21.
//  Copyright © 2021 ludmyla almeida. All rights reserved.
//

import FirebaseDatabase
import FirebaseAuth

public class AuthManager {
    
    static let shared = AuthManager()
    
    // MARK : - Public
    
    public func registerNewUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
        
        /*
         - Check if email is available
         */
        DatabaseManager.shared.canCreateAccount(with: email) { canCreate in
            if canCreate {
                /*
                    - Create Account
                    - Insert Account to dabatase
                */
                Auth.auth().createUser(withEmail: email, password: password) {
                    result, error in
                    guard error == nil, result != nil  else {
                        //Firebase auth cannot create account
                        completion(false)
                        return
                    }
                    // insert into database
                    DatabaseManager.shared.insertNewUser(with: email) { inserted in
                        if inserted {
                            completion(true)
                            return
                        } else {
                            completion(false)
                        }
                        
                    }
                    
                }
            } else {
                completion(false)
            }
            
        }
        
        
    }
    
    public func loginUser(email:String?, password:String, completion: @escaping (Bool) -> Void) {
        if let email = email {
            // email login
            Auth.auth().signIn(withEmail: email, password: password) {
                (authResult, error) in guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                //user sign in successfully
                completion(true)
            }
            
        }
    }
}
