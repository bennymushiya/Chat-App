//
//  Services.swift
//  ChatApp
//
//  Created by benny mushiya on 04/07/2020.
//  Copyright © 2020 CRC Training. All rights reserved.
//

import Firebase


struct Services {
    
    
    // this is how you fetch the users thats in your database and populate your app. with the completion handler that access the array of users, everytime we call this function we will get an array of users
    static func fetchUsers(completion: @escaping([User]) -> Void) {
        
        // we declare or call the user array
        var users = [User]()
        
        //this line of code gets the document in the database as a snapshot
        COLLECTION_USERS.getDocuments { (snapshot, error) in
           
            // loops through the users inside the data base
            snapshot?.documents.forEach({ document in
                print(document.data())
                
                // we are assigning the the data inside the document database to the dictionary we created in the users file
                let dictionary = document.data()
                
                // we are assigning user to the user file we created, meaning we gain full access of the entire dictionary with its keys and values
                let user = User.init(dictionary: dictionary)
                
                //everytime we get create a user with the above code, the code below appends the new into the array, meaning we add a new user into the array
                users.append(user)
                
                // after we append we execute our completion handler 
                completion(users)
                
            })
            
            
        }
        
    }
    
    // fetches the user with their UID, so it goes to the database and grabs their UID and fetches them. and we have access to that user with our completion block
    static func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        
        COLLECTION_USERS.document(uid).getDocument { (snapshot, error) in
            guard let dictionary = snapshot?.data() else {return}
            
            let user = User(dictionary: dictionary)
            completion(user)
        }
        
        
    }
    
    static func FetchConversations(completion: @escaping([Conversation]) -> Void) {
        var conversations = [Conversation]()
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
    let query = COLLECTION_MESSAGES.document(uid).collection("recent-messages").order(by: "timestamp")
        
        // we wrote this so both messages show up in real time.
        query.addSnapshotListener { (snapshot, error) in
            snapshot?.documentChanges.forEach({ change in
                let dictionary = change.document.data()
                let message = Message(dictionary: dictionary)
                
                
                // we call the fetch 1 user function here because we needed the message toID, in order to figure out what user were gonna fetch. so we fetch the message first to grab that ID
                self.fetchUser(withUid: message.toId) { (user) in
                    let conversation = Conversation(user: user, message: message)
                    conversations.append(conversation)
                    completion(conversations)
                }
            })
        }
        
    }
    
    // fetching the chat for a particular user, so whoever is logged in and clicks on the other person. the completion handler gives us back all the messages we've fetched
    static func fetchMessages(forUser user: User, completion: @escaping([Message]) -> Void) {
        
        var message = [Message]()
        
        
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        // here we are asking the database to go through the document that contains both the current user messages and user.uid messages and order them by timestamp
        let query = COLLECTION_MESSAGES.document(currentUid).collection(user.uid).order(by: "timestamp")
        
        // the snapshotListener lets us know everytime a something is added to the database, therefore it fetches the data and gives it back to us. this is the one that helps us get that real time effect so we dont have to refresh a database to see new messages come up.
        query.addSnapshotListener { (snapshot, error) in
            
            // here we look at all the changes in the document
            snapshot?.documentChanges.forEach({ (change) in
                
                // and if data has been added
                if change.type == .added {
                    
                    // here is how we the new changes in the database.
                    let dictionary = change.document.data()
                    
                    // we append the new data into our messages array, we called above.
                    message.append(Message(dictionary: dictionary))
                    
                    //execute our completion block
                     completion(message)
                }
            })
        }
        
    }
    
    
    static func uploadMessage(_ message: String, to user: User, completion: ((Error?) -> Void)?) {
          
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let data = ["text": message,
                    "fromId": currentUid,
                    "toId": user.uid,
                    "timestamp": Timestamp(date: Date())] as [String: Any ]
        
        
        // this is setting up a double collection were we save both messages from the current user and the user their talking to.
       COLLECTION_MESSAGES.document(currentUid).collection(user.uid).addDocument(data: data) { _ in
        
        COLLECTION_MESSAGES.document(user.uid).collection(currentUid).addDocument(data: data, completion: completion)
        
        
        // setdata overwrites information whilst addDocument, that we mentioned above adds the document into database. the reason we have two similar but slightly different block of codes is because we have to fetch both users to display the most recent message, the current user and the user they last spoke to
        COLLECTION_MESSAGES.document(currentUid).collection("recent-messages").document(user.uid).setData(data)
        
        // the fact that weve implemented it inside the upload message function means that the toId and fromId should always remain the same because its already inside the messages between the two users so only the timestamp and text will be different.
        COLLECTION_MESSAGES.document(user.uid).collection("recent-message").document(currentUid).setData(data)
        
        }
    }
    
}
