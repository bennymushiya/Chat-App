//
//  AuthService.swift
//  ChatApp
//
//  Created by benny mushiya on 02/07/2020.
//  Copyright © 2020 CRC Training. All rights reserved.
//

import Firebase
import UIKit


struct registrationCredentials {
    
    let email: String
    let username: String
    let password: String
    let fullname: String
    let profileImage: UIImage
    
}

struct AuthService {
    
    static let shared = AuthService()
    
    
    
    func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
       
        Auth.auth().signIn(withEmail: email, password: password, completion: completion )

           
        }
        
func createUser(credentials: registrationCredentials, completion: ((Error?) -> Void)?) {
        
        // compressionQuality is very important, it helps with the speed and loading of an image. depending on the size of the image the higher you want the qaulity.
    guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else {return}
               
               // uploads the information as strings
               let fileName = NSUUID().uuidString
               
               //creates a uid for each images that is being uploaded
               let ref = Storage.storage().reference(withPath: "/profile_Images\(fileName)")
               
               // this block of code uploads the images to the database
               ref.putData(imageData, metadata: nil) { (meta, error) in
                   if let error = error {
                       print("failed to uploadimage \(error.localizedDescription)")
                    return
                   }
               }
               
               // this code collects/gets the uploaded image url
               ref.downloadURL { (url, error) in
                   guard let profileImageUrl = url?.absoluteString else {return}
                   
               // tells the database to create a user
    Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (results, error) in
                   if let error = error {
                       print("failed to create user \(error.localizedDescription)")
                    return
                   }
                   
                    guard let uid = results?.user.uid else {return}
                   
        let data = ["email": credentials.email,
                    "fullName": credentials.fullname,
                    "profileImageUrl": profileImageUrl,
                    "userName": credentials.username,
                    "uid": uid] as [String: Any]
                   
        Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
                   
        }
    }
}
    
}
