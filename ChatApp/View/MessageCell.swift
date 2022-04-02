//
//  MessageCell.swift
//  ChatApp
//
//  Created by benny mushiya on 08/07/2020.
//  Copyright © 2020 CRC Training. All rights reserved.
//

import UIKit


class MessageCell: UICollectionViewCell {
    
    
    //MARK: - PROPERTIES
    
    var message: Message? {
        didSet { configure() }
    }
    
    // i create these constraints as class level properties so they can be used by the entire class
    var bubbleLeftAnchor: NSLayoutConstraint!
    var bubbleRightAnchor: NSLayoutConstraint!
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        
        return iv
    }()
    
    
    private let textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor? = .clear
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.textColor = .white
        
        
        // prevents users to tap on it and change the messages inside of it
        tv.isEditable = false
        
        return tv
    }()
    
    private let bubbleContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPurple
        
        return view
    }()
    
    
    
    //MARK: - LIFECYCLE
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        
        
        
    }
    
    
    
    //MARK: - HELPERS
    
    func configureUI() {
        
        addSubview(profileImageView)
        profileImageView.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 8, paddingBottom: 5)
        profileImageView.setDimensions(height: 32, width: 32)
        profileImageView.layer.cornerRadius = 32 / 2
        
        addSubview(bubbleContainer)
        bubbleContainer.layer.cornerRadius = 12
        bubbleContainer.anchor(top: topAnchor, bottom: bottomAnchor)
        
        //makes sure the max height is equal to 250, if its less than that
        bubbleContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        
        // its storing these two constraints into a property and also setting our constraints for us aswel, thats the reason we dont need to give bubbleContainer any constraints above.
        bubbleLeftAnchor = bubbleContainer.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12)
              
        bubbleLeftAnchor.isActive = false
              
        bubbleRightAnchor = bubbleContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: -12)
              
        bubbleRightAnchor.isActive = false
        
        // adds the textView inside the bubble container
        bubbleContainer.addSubview(textView)
        textView.anchor(top: bubbleContainer.topAnchor, left: bubbleContainer.leftAnchor, bottom: bubbleContainer.bottomAnchor, right: bubbleContainer.rightAnchor, paddingTop: 4, paddingLeft: 12, paddingBottom: 4, paddingRight: 12)
        
        
        
    }
    
    //MARK: - ACTION
    
    func configure() {
        
        // we check to make sure the message exists 
        guard let message = message else { return }
        
        // we create the viewModel instance only inside this function becuase it handles all the messaging services
        let viewModel = MessageViewModel(message: message)
        
        // we set the backgroundColor of the bubbleContainer, through the viewModel boolean data type we created
        bubbleContainer.backgroundColor = viewModel.messageBackgroundColor
        
        // we set the textColor through ViewModel aswel.
        textView.textColor = viewModel.messageTextColor
        textView.text = message.text
        
        bubbleRightAnchor.isActive = viewModel.rightAnchorActive
        bubbleLeftAnchor.isActive = viewModel.leftAnchorActive
        
        profileImageView.isHidden = viewModel.shouldHideProfileImage
        
        profileImageView.sd_setImage(with: viewModel.imageUrl)
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
  
    
    
    
}

