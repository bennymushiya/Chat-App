//
//  RegistrationController.swift
//  ChatApp
//
//  Created by benny mushiya on 26/06/2020.
//  Copyright © 2020 CRC Training. All rights reserved.
//

import UIKit
import Firebase


class RegistrationController: UIViewController {
    
    
    //MARK: - PROPERTIES
    
    private var viewModel = RegistrationViewModel()
    
    // we create this as a class level variable because were going to use this in mulitiple places in our application. we put it as optional because it starts off as empty
    private var profileImage: UIImage?
    
    private let addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "person"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        
        
        return button
    }()
    
    private lazy var emailContainerView: UIView = {
        return InputContainerView(image: #imageLiteral(resourceName: "lock"), textField: emailTextField)
        
        
    }()
    
    private lazy var fullNameContainerView: UIView = {
       return InputContainerView(image: UIImage(systemName: "lock"), textField: fullNameTextField)
        
        
    }()
    
    private lazy var userNameContainerView: UIView = {
       return InputContainerView(image: UIImage(systemName: "lock"), textField: userNameTextField)
        
    }()
    
    private lazy var passwordContainerView: UIView = {
        return InputContainerView(image: #imageLiteral(resourceName: "mail"), textField: passwordTextField)
        
        
    }()
    
    private let emailTextField: UITextField = {
        let tf = CustomTextField(placeholder: "email")
        tf.keyboardType = .emailAddress
        tf.placeholder = "email"
        
        return tf
    }()
    
    private let fullNameTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "fullname")
        tf.placeholder = "fullname"
        return tf
    }()
    
    private let userNameTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "userName")
        tf.placeholder = "username"
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = CustomTextField(placeholder: "password")
         tf.placeholder = "password"
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let registerButton: AuthButton = {
        
        let button = AuthButton(title: "register", type: .system)
        button.setTitle("register", for: .normal)
        button.isEnabled = true
        button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
    
        return button
        
    }()
    
    private let alreadyHaveAnAccount: UIButton = {
           let button = UIButton()
           
        let attributedText = NSMutableAttributedString(string: " already have an account?",
                                                     attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .heavy), .foregroundColor: UIColor.white])
           
           
           attributedText.append(NSMutableAttributedString(string: " Log in",
                                                     attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .heavy), .foregroundColor: UIColor.white]))
           
           button.setAttributedTitle(attributedText, for: .normal)
           button.addTarget(self, action: #selector(handleLogIn), for: .touchUpInside)
           
           return button
       }()
    
    
      //MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
    
        configureGradientLayer()
        configureUI()
        notificationObservers()
      
        
    }
    
    
    
    
      //MARK: - HELPERS
    
    func configureUI() {
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(addPhotoButton)
        addPhotoButton.centerX(inView: view)
        addPhotoButton.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 70, paddingLeft: 70, paddingRight: 70)
        addPhotoButton.setHeight(height: 200)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, fullNameContainerView, userNameContainerView, passwordContainerView, registerButton])
        
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: addPhotoButton.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 200, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(alreadyHaveAnAccount)
        alreadyHaveAnAccount.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 32, paddingBottom: 16, paddingRight: 16)
        
        
    }
    
    func checkFormStatus() {
           
        if viewModel.formIsValid {
            registerButton.isEnabled = true
            registerButton.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
            
           } else {
            
            registerButton.isEnabled = false
            registerButton.backgroundColor = #colorLiteral(red: 0.6148123741, green: 0.1017967239, blue: 0.1002308354, alpha: 1)
            
           }
           
           
       }
    
    
    
    func notificationObservers() {
        
    emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    fullNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    userNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
    }
    
    
    
    //MARK: - SELECTOR
    
    @objc func handleSelectPhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @objc func handleLogIn() {
        
        // takes you back to the previous screen
       // navigationController?.popViewController(animated: true)
        
        let controller = LogInController()
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
        
    }
    
    
    @objc func textDidChange(sender: UITextField) {
        
        if sender == emailTextField {
            viewModel.email = sender.text
            
        } else if sender == fullNameTextField {
                viewModel.fullName = sender.text
            
        } else if sender == userNameTextField {
                    viewModel.userName = sender.text
                    
                } else {
                    viewModel.password = sender.text
                }
        
        checkFormStatus()
}
            
        
    @objc func handleRegistration() {
        
        guard let email = emailTextField.text else {return}
        guard let fullName = fullNameTextField.text else {return}
        guard let userName = userNameTextField.text?.lowercased() else {return}
        guard let password = passwordTextField.text else {return}
        guard let profileImage = profileImage else {return}
        
        
        
        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else {return}
        
        let fileName = NSUUID().uuidString
        
        let uploadImage = Storage.storage().reference(withPath: "images\(fileName)")
        
        uploadImage.putData(imageData, metadata: nil) { (metadata, error) in
            if let error = error {
                print("it did not upload\(error.localizedDescription)")
                return
            }
            
            uploadImage.downloadURL { (url, error) in
                guard let imageUrl = url?.absoluteString else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("unsuccesful in creating the user \(error.localizedDescription)")
                return
                
            }
            
            guard let uid = result?.user.uid else {return}
            
            let data = ["email": email,
                        "username": userName,
                        "fullname": fullName,
                        "imageUrl": imageUrl,
            "uid": uid] as [String: Any]
            
        Firestore.firestore().collection("users").document(uid).setData(data) { (error) in
                if let  error = error {
                    print("failed to create uid\(error.localizedDescription)")
                    return
                    
                }
            
            
            
            
            
            }
            
            
        }
    }
            
}
        
        
        
        
//        let credentials = registrationCredentials(email: email, username: userName, password: password, fullname: fullName, profileImage: profileImage)
//
//
//    AuthService.shared.createUser(credentials: credentials) { error in
//            if let error = error {
//                print("it didnt log you in unoe\(error.localizedDescription)")
//                return
//            }
//
//        self.dismiss(animated: true, completion: nil)
//
//        }
       
        
        
    }
    
    
    
    //MARK: - APIs
    

    
    
      //MARK: - ACTION
    
    
}

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // collects chosen image from the picker
        let image = info[.originalImage] as? UIImage
        
        profileImage = image
        
        // sets the image to our button
        addPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        addPhotoButton.layer.borderColor = UIColor.white.cgColor
        addPhotoButton.layer.borderWidth = 3.0
        addPhotoButton.layer.cornerRadius = 200 / 2
        
        
        
        
        
        dismiss(animated: true, completion: nil)
    }
    
}
