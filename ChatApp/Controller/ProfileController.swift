//
//  ProfileController.swift
//  ChatApp
//
//  Created by benny mushiya on 07/08/2020.
//  Copyright © 2020 CRC Training. All rights reserved.
//

import UIKit
import Firebase


private let reuseIdentifier = " profile cell"


class ProfileController: UITableViewController {
    
    
    //MARK: - PROPERTIES
    
    private var user: User?
    
    private lazy var headerView = ProfileHeader(frame: .init(x: 0, y: 0, width: view.frame.width, height: 380))
    
    
    
    //MARK: - LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchUser()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    
    //MARK: - HELPERS
    
    
    
    func configureUI() {
        
        tableView.backgroundColor = .white
        
        headerView.delegate = self
        
        tableView.tableHeaderView = headerView
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)

        tableView.tableFooterView = UIView()
        
        // removes the top spacing pf the view
        tableView.contentInsetAdjustmentBehavior = .never

    }
    
    
    
    //MARK: - APIS
    
    func fetchUser() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Services.fetchUser(withUid: uid) { user in
            self.user = user
            
        }
        
        
    }
    
    //MARK: - ACTION
    
    
    
}


extension ProfileController {

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 2
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        return cell
    }

}


//MARK: - ProfileHeaderDelegate


extension ProfileController: ProfileHeaderDelegate {
    
    func dismissController() {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
