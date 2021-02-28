//
//  AuthManager.swift
//  DiaryApp
//
//  Created by Evgenii Kolgin on 16.11.2020.
//

import FirebaseAuth

public class AuthManager {
    
    static let shared = AuthManager()
    
    public func registerNewUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
        
//         Check if email is available
        
        DatabaseManager.shared.canCreateNewUser(with: email) { canCreate in
            if canCreate {
                /*
                 - Create account
                 - Insert account to database
                 */
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    guard error == nil, result != nil else {
                        // firebase auth could not create account
                        print("Firebase auth could not create account")
                        completion(false)
                        return }
                        // insert into database
                    DatabaseManager.shared.insertNewUser(with: email, result: result!.user.uid) { (inserted) in
                        if inserted {
                            completion(true)
                            return
                        } else {
                            //Failed to insert to database
                            print("Failed to insert to database")
                            completion(false)
                            return
                        }
                    }
                    completion(true)
                    }
                } else {
                    // either username or email does not exist
                    print("error")
                    completion(false)
            }
        }
    }
    
    public func loginUser(email:String?, password:String, completion: @escaping (Bool) -> Void) {
        
        if let email = email {
            //email log in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return }
                
                completion(true)
            }
        } 
    }
    
    public func logOut(completion: (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        } catch {
            print(error)
            completion(false)
            return
        }
    }
    
}
