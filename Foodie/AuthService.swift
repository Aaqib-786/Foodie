//
//  AuthService.swift
//  Foodie
//
//  Created by Aaqib Seliya on 13/12/2022.
//

import Firebase

class AuthService {
    // MARK: - Create User With Email and Password
    func createUser(email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let err = error {
                completion(nil, err)
                return
            }
            completion(result, error)
        }
    }
    
    // MARK: - Create User With Email and Password
    func signInWithEmail (email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let err = error {
                completion(nil, err)
                return
            }
            completion(result, error)
        }
    }
}
