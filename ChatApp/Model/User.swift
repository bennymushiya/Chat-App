//
//  User.swift
//  ChatApp
//
//  Created by benny mushiya on 04/07/2020.
//  Copyright © 2020 CRC Training. All rights reserved.
//

import Foundation



struct User {
    
    let uid: String
    let imageUrl: String
    let email: String
    let username: String
    let fullname: String
    
    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        
        
    }
    
    
}
