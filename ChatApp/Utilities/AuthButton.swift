//
//  AuthButton.swift
//  ChatApp
//
//  Created by benny mushiya on 27/06/2020.
//  Copyright © 2020 CRC Training. All rights reserved.
//

import UIKit


class AuthButton: UIButton {
    
    
    init(title: String, type: ButtonType) {
        super.init(frame: .zero)
        
        UIButton(type: .system)
        layer.cornerRadius = 5
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        setTitleColor(.white, for: .normal)
        setHeight(height: 50)
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
