//
//  ConversationCell.swift
//  ChatApp
//
//  Created by benny mushiya on 10/07/2020.
//  Copyright © 2020 CRC Training. All rights reserved.
//

import UIKit


class ConversationCell: UITableViewCell {
    
    //MARK: - PROPERTIES
    
    var conversation: Conversation? {
        didSet { configure() }
    }
    
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        
        return iv
    }()
    
    
    let timestampLabel: UILabel = {
        let ts = UILabel()
        ts.font = UIFont.systemFont(ofSize: 12)
        ts.text = "2h"
        ts.textColor = .darkGray
        
        
        return ts
        
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        
        return label
    }()
    
    let messageTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    
    //MARK: - LIFECYCLE
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        profileImageView.anchor(left: leftAnchor, paddingLeft: 13)
        profileImageView.setDimensions(height: 50, width: 50)
        profileImageView.layer.cornerRadius = 50 / 2
        profileImageView.centerY(inView: self)
        
        let stack = UIStackView(arrangedSubviews: [usernameLabel, messageTextLabel])
        stack.axis = .vertical
        stack.spacing = 4
        
        addSubview(stack)
        stack.centerY(inView: profileImageView)
        stack.anchor(left: profileImageView.rightAnchor, right: rightAnchor, paddingLeft: 20, paddingRight: 16)
        
        addSubview(timestampLabel)
        timestampLabel.anchor(top: topAnchor, right: rightAnchor, paddingTop: 20, paddingRight: 12)
        
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    //MARK: - HELPERS
    
    func configure() {
        
        guard let conversation = conversation else { return }
        
        let viewModel = ConversationViewModel(conversation: conversation)
        
        usernameLabel.text = conversation.user.username
        messageTextLabel.text = conversation.message.text
        
        timestampLabel.text = viewModel.timeStamp
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        
    }
    
    //MARK: - ACTION
    
}
