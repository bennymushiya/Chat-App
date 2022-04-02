//
//  MessageViewModel.swift
//  ChatApp
//
//  Created by benny mushiya on 08/07/2020.
//  Copyright © 2020 CRC Training. All rights reserved.
//

import UIKit


struct MessageViewModel {
    
    private let message: Message
    
    var messageBackgroundColor: UIColor {
        return message.isFromCurrentUser ? .lightGray : .systemPurple
        
        
    }
    
    var messageTextColor: UIColor {
        
        return message.isFromCurrentUser ? .black : .white
        
    }
    
    // this block of code helps us to decide which side the message being sent is going to be anchored to.
    var rightAnchorActive: Bool {
        
        // if the message is from the current user then it will be anchored to the right hand side.
        return message.isFromCurrentUser
    }
    
    // this is the opposite if its not from the current user then the message will be anchored to the left.
    var leftAnchorActive: Bool {
        
        return !message.isFromCurrentUser
    }
    
    // if the message is from the current user then we should hide the profile image or esle we should show it.
    var shouldHideProfileImage: Bool {
        
        return message.isFromCurrentUser
    }
    
    
    var imageUrl: URL? {
        
        guard let user = message.user else { return nil}
        return URL(string: user.imageUrl)
    }
    
    init(message: Message) {
        self.message = message
    }
}
