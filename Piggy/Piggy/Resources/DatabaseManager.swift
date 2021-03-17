//
//  DatabaseManager.swift
//  Piggy
//
//  Created by ludmyla almeida on 3/10/21.
//  Copyright © 2021 ludmyla almeida. All rights reserved.
//

import FirebaseDatabase

public class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    /// Check if email is available
    /// - Parameters
    ///     - email: String representing email
    public func canCreateAccount(with email: String, completion: (Bool) -> Void) {
        completion(true)
    }
    
    public func insertNewUser(with email: String, completion: @escaping (Bool) -> Void) {
        
        database.child(email.safeDatabaseKey()).setValue(["email": email]) { error, _ in
            if error == nil {
                //succeeded
                completion(true)
                return
            } else {
                //failed
                completion(false)
                return
            }
        }
    }
    
    
    
}
