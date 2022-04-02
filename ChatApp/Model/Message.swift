//
//  Message.swift
//  ChatApp
//
//  Created by benny mushiya on 08/07/2020.
//  Copyright © 2020 CRC Training. All rights reserved.
//

import Firebase

// this gives us an idea of what the data we need to upload will look like.

struct Message {
    
    let text: String
    
    // the user ID the message going too
    let toId: String
    
    // the user ID the messages are coming from.
    let fromId: String
    
    // to tell the time the message was sent.
    let timestamp: Timestamp!
    
    // its gonna be used to load data about the user, as we need their profileImageUrl. we call an object so we can grab the profile image, becasue weve already stored it in our dataBase, rather than storing it again.
    var user: User?
    
    
    let isFromCurrentUser: Bool
    
    
    // a dictionary of all the information i want saved, the corresponding attribute thats comes from firebase will be set to these objects that has the same key value pairs.
    init(dictionary: [String: Any]) {
        self.text = dictionary["text"] as? String ?? ""
        self.toId = dictionary["toId"] as? String ?? ""
        self.fromId = dictionary["fromId"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        
        self.isFromCurrentUser = fromId == Auth.auth().currentUser?.uid
        
    }
    
}

// this is its own data model that were going to use to only store the most recent messages and we need the user and messages 
struct Conversation {
    
    let user: User
    let message: Message
    
    
}


