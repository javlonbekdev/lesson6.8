//
//  User.swift
//  lesson8.8
//
//  Created by Javlonbek on 05/02/22.
//

import Foundation
class User {
    var uid: String?
    var email: String?
    var displayName: String?
    
    init(uid: String, email: String, displayName: String) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
    }
}
