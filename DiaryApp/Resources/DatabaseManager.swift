//
//  DatabaseManager.swift
//  InstagramApp
//
//  Created by Evgenii Kolgin on 04.11.2020.
//

import Firebase
public class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let db = Firestore.firestore()
    
    //MARK: - Public
    
    public func canCreateNewUser(with email:String, completion: (Bool) -> Void) {
        completion(true)
    }
    
    public func insertNewUser(with email:String, result: String, completion: @escaping (Bool) -> Void) {
        db.collection("users").addDocument(data: ["email":email, "uid":result]) { (error) in
            if error == nil {
                // succeded
                completion(true)
                return
            } else {
                // failed
                completion(false)
                return
            }
        }
    }
}

