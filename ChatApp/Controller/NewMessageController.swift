//
//  NewMessageController.swift
//  ChatApp
//
//  Created by benny mushiya on 03/07/2020.
//  Copyright © 2020 CRC Training. All rights reserved.
//

import UIKit

private let reuseIdentifier = "userCell"


protocol NewMessageControllerDelegate: class {
    
    func controller(_ controller: NewMessageController, wantsToStartChatWith user: User)
}

class NewMessageController: UITableViewController {
    
    
    //MARK: - PROPERTIES
    
    private var users = [User]()
    
    weak var delegate: NewMessageControllerDelegate?
    
    
    //MARK: - LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchUsers()
        
    }
    
    
    
    //MARK: - HELPERS
    
    func configureUI() {
        
        configureNavigationBar(withTitle: "newMessage", prefersLargeTitles: false)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismisall))
        
        //gets rid of all the separtors in a tableView
        tableView.tableFooterView = UIView()
        
        // here we register the userCellView, so everthing we do there will show here
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        // establishes the height of each cell
        tableView.rowHeight = 80
        
    }
    
    //MARK: - SELECTORS
    
    @objc func handleDismisall() {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    //MARK: - APIs
    
    func fetchUsers() {
        Services.fetchUsers { users in
            self.users = users
            
            self.tableView.reloadData()
            
        }
        
    }
    
    //MARK: - ACTION
    
    
    
    
}



//MARK: - UITableViewDataSource

extension NewMessageController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // this enables us to reuse the same identifier, but enabling us to populate it with different things 
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        
        // when we call this it means the didset code in userCell gets called
        cell.user = users[indexPath.row]
        
        return cell
        
        
    }
    
    
}



extension NewMessageController {
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        delegate?.controller(self, wantsToStartChatWith: users[indexPath.row])
        
    }
}
