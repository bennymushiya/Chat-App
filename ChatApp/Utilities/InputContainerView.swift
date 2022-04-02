//
//  InputContainerView.swift
//  ChatApp
//
//  Created by benny mushiya on 26/06/2020.
//  Copyright © 2020 CRC Training. All rights reserved.
//

import UIKit



class InputContainerView: UIView {
    
    
    init(image: UIImage?, textField: UITextField) {
        super.init(frame: .zero)
        
        setHeight(height: 50)
        
        
        // creates the property
        let mp = UIImageView()
        mp.image = image
        mp.tintColor = .white
        mp.alpha = 0.87
        
        // adds the image property
        addSubview(mp)
        mp.centerY(inView: self)
        mp.anchor(left: leftAnchor, paddingLeft: 8)
        mp.setDimensions(height: 28, width: 28)
        
        
        //adds the textfield
        addSubview(textField)
        textField.centerY(inView: self)
        textField.anchor(left: mp.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 8, paddingBottom: -8)
               
        let dividerView = UIView()
        
        //this is the underline view thats at below the email and password
        dividerView.backgroundColor = .white
        addSubview(dividerView)
        dividerView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 8, height: 0.75)

        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
