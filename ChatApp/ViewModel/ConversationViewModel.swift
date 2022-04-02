//
//  ConversationViewModel.swift
//  ChatApp
//
//  Created by benny mushiya on 07/08/2020.
//  Copyright © 2020 CRC Training. All rights reserved.
//

import UIKit



struct ConversationViewModel {
    
    private let conversations: Conversation
    
    // gets the profile image for conversation cell
    var profileImageUrl: URL? {
        
        return URL(string: conversations.user.imageUrl)
        
    }
    
    // how we get the date format
    var timeStamp: String {
        let date = conversations.message.timestamp.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
    
    
    init(conversation: Conversation) {
        self.conversations = conversation
        
        
    }
    
    
    
}
