//
//  ChatController.swift
//  ChatApp
//
//  Created by benny mushiya on 06/07/2020.
//  Copyright © 2020 CRC Training. All rights reserved.
//

import UIKit

private let reuseIdentifier = "collectionCell"

class ChatController: UICollectionViewController {
    
    
    //MARK: - PROPERTIES
    
    
    private let user: User
    
    private var messages = [Message]()
    
    var fromCurrentUser = false
    
    private lazy var customInputView: CustomInputAccessoryView = {
        let iv = CustomInputAccessoryView(frame: CGRect(x: 0, y: 0,
                                                        width: view.frame.width,
                                                        height: 50))
        iv.delegate = self
        return iv
    }()
    
    
    
    //MARK: - LIFECYCLE
    
    
    init(user: User) {
        self.user = user
        // collection view has to be initialised by a collection view layout
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchMessages()
        
    }
    
    override var inputAccessoryView: UIView? {
        get { return customInputView }
    }
    
    override var canBecomeFirstResponder: Bool {
        
        get { return true }
         
    }
    
    
    //MARK: - APIS
    
    func fetchMessages() {
        Services.fetchMessages(forUser: user) { messages in
            self.messages = messages
            self.collectionView.reloadData()
            
            // whenever we send or recieve a new message this code automaticly scrolls down for us.
            self.collectionView.scrollToItem(at: [0, self.messages.count - 1], at: .bottom, animated: true)
            
        }
        
    }
   
    
    
    //MARK: - HELPERS
    
    func configureUI() {
        
        collectionView.backgroundColor = .white
        
        // because we initialise the this controller with a user, that means can make the controller apear with the user name
        configureNavigationBar(withTitle: user.username, prefersLargeTitles: false)
        
        // registering and adding our collection cell
        collectionView.register(MessageCell.self,forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.alwaysBounceVertical = true
           
        // dismisses the keyboard whenever we scroll up
        collectionView.keyboardDismissMode = .interactive
    }
    
    
    
    
    //MARK: - ACTIONS
    
    
    
}

//MARK: - UICollectionViewDataSource

extension ChatController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return messages.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MessageCell
        
        cell.message = messages[indexPath.row]
        cell.message?.user = user
        
        return cell
        
    }
    
}


//MARK: - UICollectionViewDelegate

// customizes the apearance and size of number of cells/sections weve demanded above.
extension ChatController: UICollectionViewDelegateFlowLayout {
    
    //customizes the padding and spacing of the cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return.init(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    
    // customizes the height and width of the cells.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // if the height of the messages being sent is less than 50 height nothing happens but if its greater than 50 height then, layout if needed is called at the bottom.
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let estimateSizeCell = MessageCell(frame: frame)
        estimateSizeCell.message = messages[indexPath.row]
        estimateSizeCell.layoutIfNeeded()
        
        let targetSize = CGSize(width: view.frame.width, height: 1000)
        let estimateSize = estimateSizeCell.systemLayoutSizeFitting(targetSize)
        
        return .init(width: view.frame.width, height: estimateSize.height)
    }
    
}

//MARK: - CustomInputAccessoryViewDelegate

extension ChatController: CustomInputAccessoryViewDelegate {
    
    func inputView(_ inputView: CustomInputAccessoryView, wantsToSend message: String) {
        
        Services.uploadMessage(message, to: user) { (error) in
            if let error = error {
                print("failed to upload messages \(error.localizedDescription)")
                return
            }
            
            // resets the text after its been sent.
            inputView.clearMessage()
            
        }
        
    }
    
}
