//
//  UserCell.swift
//  ChatApp
//
//  Created by benny mushiya on 03/07/2020.
//  Copyright © 2020 CRC Training. All rights reserved.
//

import UIKit
import SDWebImage


class UserCell: UITableViewCell {
    
    
    //MARK: - PROPERTIES
    
    // the didset code helps us figure out when the user gets set, then calls the configure function at the bottom that includes all the users data 
    var user: User? {
        didSet { configure() }
    }
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.backgroundColor = .red
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
       
        return label
    }()
    
    
       private let fullNameLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 14)
           
           return label
       }()
    
    
    
    //MARK: - LIFECYCLE
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        profileImageView.setDimensions(height: 64, width: 64)
        profileImageView.layer.cornerRadius = 64 / 2
        
        let stack = UIStackView(arrangedSubviews: [userNameLabel, fullNameLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 2
        
        addSubview(stack)
        stack.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 13)
        
        
    }
    
    
    //MARK: - HELPERS
    
    
    func configure() {
        
        guard let user = user else {return}
        fullNameLabel.text = user.fullname
        userNameLabel.text = user.username
        
        guard let url = URL(string: user.imageUrl) else {return}
        
        // helps us fetch the image from our database really quickly 
        profileImageView.sd_setImage(with: url)
        
        
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
