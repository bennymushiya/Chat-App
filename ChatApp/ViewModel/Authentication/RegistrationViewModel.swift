//
//  RegistrationViewModel.swift
//  ChatApp
//
//  Created by benny mushiya on 27/06/2020.
//  Copyright © 2020 CRC Training. All rights reserved.
//

import Foundation


struct RegistrationViewModel: AuthenticationProtocol {

    var email: String?
    var password: String?
    var fullName: String?
    var userName: String?
        
    
     //tells us whether we have a valid form or not.
    var formIsValid: Bool {

        // these will return true if both field is not empty, if one is filled without the other it still returns false
        return email?.isEmpty == false
            && password?.isEmpty == false
            && fullName?.isEmpty == false
            && userName?.isEmpty == false
        
        
    }
        
    
    
    
    
}
