//
//  APIManager.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 12.02.2021.
//

import FirebaseAuth
import FirebaseFirestore

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
}

struct APIManager {
    
    static let COLLECTION_USERS     = Firestore.firestore().collection("users")
    static let COLLECTION_BUDGETS   = Firestore.firestore().collection("budgets")
    
    static func save(budget: Budget, completed: @escaping (Error?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let document: [String : Any] = ["userID" : uid,
                                        "name" : budget.name,
                                        "amount" : budget.budgetedAmount,
                                        "currency" : budget.currencyType,
                                        "spent" : budget.spentAmount,
                                        "reset" : budget.resetDate,
                                        "recurrance" : budget.recurrance]
        
        _ = COLLECTION_BUDGETS.addDocument(data: document) { error in
            if let error = error {
                completed(error)
                return
            }
            
            completed(nil)
        }
    }
    
    static func getDataForLoggedInUser(completed: @escaping (Result<User, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            if let error = error {
                completed(.failure(error))
                return
            }
            
            guard let dictionary = snapshot?.data() else { return }
            
            let user = User(dictionary: dictionary)
            completed(.success(user))
        }
    }
    
    static func loginUser(withEmail email: String, password: String, completed: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                completed(error)
                return
            }
            completed(nil)
        }
    }
    
    static func registerUser(withCredentials credentials: AuthCredentials, completed: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
            if let error = error {
                completed(error)
                return
            }
            
            guard let result = result else {
                return
            }
            
            let uid = result.user.uid
            
            let data: [String : Any] = ["email" : credentials.email,
                                        "fullname" : credentials.fullname,
                                        "uid" : uid]
            
            COLLECTION_USERS.document(uid).setData(data) { error in
                guard let error = error else {
                    completed(nil)
                    return
                }
                completed(error)
            }
        }
    }
}
