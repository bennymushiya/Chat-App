//
//  CustomTextfField.swift
//  ChatApp
//
//  Created by benny mushiya on 27/06/2020.
//  Copyright © 2020 CRC Training. All rights reserved.
//

import UIKit


class CustomTextField: UITextField {
    
    
    
    
    init(placeholder: String?) {
     super.init(frame: .zero)
    
    
        font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        textColor = .white
        keyboardAppearance = .dark
        self.placeholder = placeholder
        
        
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
