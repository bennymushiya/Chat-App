
//
//  LogInController.swift
//  ChatApp
//
//  Created by benny mushiya on 26/06/2020.
//  Copyright © 2020 CRC Training. All rights reserved.
//


import UIKit
import Firebase


class LogInController: UIViewController {
    
    
    //MARK: - PROPERTIES
    
    
    private var ViewModel = LogInViewModel()
    
    private let iconImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "tray.2")
        
        iv.tintColor = .white
        
        return iv
    }()
    
    
    private lazy var emailContainerView: UIView = {
        return InputContainerView(image: UIImage(systemName: "envelope"), textField: emailTextField)
    }()
    
    private lazy var passwordContainerView: UIView = {
        return InputContainerView(image: UIImage(systemName: "lock"), textField: passwordTextField)
       }()
    
    private let logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50)
       button.isEnabled = false
        button.addTarget(self, action: #selector(handleLogIn), for: .touchUpInside)
        return button
    }()
    
    private let emailTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "email")
        tf.keyboardType = .emailAddress
        //tf.placeholder = "email"
        return tf
    }()
    
    private let passwordTextField: CustomTextField = {
           let tf = CustomTextField(placeholder: "password")
        tf.isSecureTextEntry = true
        //tf.placeholder = "password"
           return tf
       }()
    
    private let dontHaveAnAccount: UIButton = {
        let button = UIButton()
        
        let attributedText = NSMutableAttributedString(string: " dont have an account?",
                                                  attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .heavy), .foregroundColor: UIColor.white])
        
        
        attributedText.append(NSMutableAttributedString(string: " sign up",
                                                  attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .heavy), .foregroundColor: UIColor.white]))
        
        button.setAttributedTitle(attributedText, for: .normal)
        button.addTarget(self, action: #selector(goToRegisterUI), for: .touchUpInside)
        
        return button
    }()
       
    
    
      //MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureGradientColor()
        configureUI()
      
    }
    
    
      //MARK: - HELPERS
    
    func checkFormStatus() {
        
        if ViewModel.formIsValid {
            logInButton.isEnabled = true
            logInButton.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
            
        } else {
            
            logInButton.isEnabled = false
            logInButton.backgroundColor = #colorLiteral(red: 0.6148123741, green: 0.1017967239, blue: 0.1002308354, alpha: 1)
            
        }
        
        
    }
    
    func configureUI() {
        
        view.backgroundColor = .systemPurple
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        iconImage.setDimensions(height: 120, width: 120)
        
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, logInButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(dontHaveAnAccount)
        dontHaveAnAccount.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 32, paddingBottom: 16, paddingRight: 16)
        
    emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
    }
    
    
    //MARK: - SELECTORS
       
    @objc func goToRegisterUI() {
             
    let controller = RegistrationController()
    let nav = UINavigationController(rootViewController: controller)
    nav.modalPresentationStyle = .fullScreen
    present(nav, animated: true, completion: nil)
            
}
       
       @objc func textDidChange(sender: UITextField) {
           
           if sender == emailTextField {
               ViewModel.email = sender.text
           }else {
               
               ViewModel.password = sender.text
           }
           
           checkFormStatus()
       }
       
       
       
       
       @objc func handleLogIn() {
           
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        
    AuthService.shared.logUserIn(withEmail: email, password: password) { result, error in
        if let error = error {
            print("its not letting you log in because \(error.localizedDescription)")
            
        }
        
        // we dismiss the screen because the conversation controller is the rootViewController, therefore, everytime a user has to log in the log in controller presents itself on top of the conversation controller, therefore if they have successfully logged in all we need to do is dismiss it then we will go back to the rootviewController.
        self.dismiss(animated: true, completion: nil)
}
        
        
        
        
        
}
    
    
    
      //MARK: - ACTION
    
    
    
  
    
}
