//
//  Conversations.swift
//  ChatApp
//
//  Created by benny mushiya on 26/06/2020.
//  Copyright © 2020 CRC Training. All rights reserved.
//

import UIKit
import Firebase


private let reuseIdentifier = " conversation cell"

class ConversationController: UIViewController {
    
    
    
    //MARK: - PROPERTIES
    
    
    //creates a table view
    private let tableView = UITableView()
    var conversations = [Conversation]()
    
    
    private let newMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.imageView?.setDimensions(height: 24, width: 24)
       button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemPurple
        
        button.addTarget(self, action: #selector(showNewMessage), for: .touchUpInside)
       
        
        return button
    }()
    
    
       //MARK: - LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authenticateUsers()

        configureTableView()
        configureUI()
        fetchConversations()
       
        //tableView.register(ConversationCell.self, forCellReuseIdentifier: reuseIdentifier)
        
    }
    
    // allows the navigation bar to apear and load correctly
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
         configureNavigationBar(withTitle: "message ", prefersLargeTitles: true)
    }
    
    
    
       //MARK: - HELPERS
    
    
    func configureUI() {
        
        let image = UIImage(named: "person")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile))
        
        view.addSubview(newMessageButton)
        newMessageButton.setDimensions(height: 56, width: 56)
        newMessageButton.layer.cornerRadius = 56 / 2
        newMessageButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 16, paddingRight: 24)
                
    }
    
    
    func presentLogInScreen() {
        
        DispatchQueue.main.async {
            let controller = LogInController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    
    
       
       func configureTableView() {
           
           tableView.backgroundColor = .white
           tableView.frame = view.frame
           tableView.rowHeight = 80
           tableView.register(ConversationCell.self, forCellReuseIdentifier: reuseIdentifier)
           tableView.tableFooterView = UIView()
           tableView.delegate = self
           tableView.dataSource = self
           
           view.addSubview(tableView)
       }
    
    func showChatController(forUser user: User) {
        let controller = ChatController(user: user)
        navigationController?.pushViewController(controller, animated: true)
        
        
    }
    
    //MARK: - SELECTORS
    
    @objc func showProfile() {
        
        let controller = ProfileController()
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
        
     
        
    }
    
    
    @objc func showNewMessage() {
        
        let controller = NewMessageController()
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
       
        
        
    }
    
    
    
    //MARK: - APIs
    
    // this is how you check if a user is signed in or not
    func authenticateUsers() {
        
        if Auth.auth().currentUser?.uid == nil {
            presentLogInScreen()
            
        }else {
            print("user is logged in \(Auth.auth().currentUser?.uid)")
            
        }
        
    }
    
    
    // this is how you sign a user out
    @objc func logOutUser() {
        
        do {
            try Auth.auth().signOut()
            presentLogInScreen()
            
        }catch {
            
            print("error signing out ")
        }
        
    }
    
    func fetchConversations() {
        
        Services.FetchConversations { (conversation) in
            self.conversations = conversation
            self.tableView.reloadData()
        }
        
        
    }
    
    
    
    
    //MARK: - ACTION
    
    
    
}


  //MARK: - TableViewDelegate

extension ConversationController: UITableViewDelegate {
    
    
    
    
}


  //MARK: - TableViewDataSource

extension ConversationController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ConversationCell
        
        cell.textLabel?.text = conversations[indexPath.row].message.text
        
        cell.conversation = conversations[indexPath.row]
        
        
        return cell
    }
    
    
    // handles the selection of a cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        // im assigning user to conversation property that i called in properties section, also, then im populating all the values inside the conversation properites in the row of each selected row, with a specicic user.
        let user = conversations[indexPath.row].user
        showChatController(forUser: user)
        
    }
}

//MARK: - NewMessageControllerDelegate


extension ConversationController: NewMessageControllerDelegate {
    
    func controller(_ controller: NewMessageController, wantsToStartChatWith user: User) {
        controller.dismiss(animated: true, completion: nil)
      
        showChatController(forUser: user)
        
    }
    
    
    
}
