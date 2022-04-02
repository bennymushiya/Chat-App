//
//  ProfileHeader.swift
//  ChatApp
//
//  Created by benny mushiya on 07/08/2020.
//  Copyright © 2020 CRC Training. All rights reserved.
//

import UIKit

protocol ProfileHeaderDelegate: class {
    
    func dismissController()
}


class ProfileHeader: UIView {
    
    
    //MARK: - PROPERTIES
    
   weak var delegate: ProfileHeaderDelegate?
    
    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.imageView?.setDimensions(height: 22, width: 22)
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        
        return button
    }()
    
    private let profileImage: UIImageView = {
          let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 4.0
           
           return iv
       }()
    
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
       
    //MARK: - LIFECYCLE
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
     
        configureUI()
        
        
    }
    
    
    //MARK: - HELPERS
    
    
    func configureUI() {
        
        configureGradientLayer()
        
        profileImage.setDimensions(height: 200, width: 200)
        profileImage.layer.cornerRadius = 200 / 2
        
        addSubview(profileImage)
        profileImage.centerX(inView: self)
        profileImage.anchor(top: topAnchor, paddingTop: 96)
        
        let stack = UIStackView(arrangedSubviews: [fullNameLabel, userNameLabel])
        stack.axis = .vertical
        stack.spacing = 4
        
        addSubview(stack)
        stack.centerX(inView: self)
        stack.anchor(top: profileImage.bottomAnchor, paddingTop: 16)
        
        addSubview(dismissButton)
        dismissButton.anchor(top: topAnchor, left: leftAnchor, paddingTop: 44, paddingLeft: 12)
        dismissButton.setDimensions(height: 48, width: 48)
        
    }
    
    
          
    func configureGradientLayer() {
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemRed.cgColor, UIColor.systemPurple.cgColor]
        gradient.locations = [0, 1]
        layer.addSublayer(gradient)
        gradient.frame = bounds
        
        
        
    }
    
    
    
          
    //MARK: - ACTION

    
    @objc func handleDismissal() {
        
        delegate?.dismissController()
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
   
    
    
}
