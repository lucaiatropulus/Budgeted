//
//  User.swift
//  Budgeted - UIKit Test
//
//  Created by Luca Nicolae Iatropulus on 14.02.2021.
//

import Foundation

struct User {
    let email: String
    let fullname: String
    let uid: String
    
    init(dictionary: [String : Any]) {
        email       = dictionary["email"] as? String ?? ""
        fullname    = dictionary["fullname"] as? String ?? ""
        uid         = dictionary["uid"] as? String ?? ""
    }
}
