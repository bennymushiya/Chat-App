//
//  CustomInputAccessoryView.swift
//  ChatApp
//
//  Created by benny mushiya on 06/07/2020.
//  Copyright © 2020 CRC Training. All rights reserved.
//

import UIKit


protocol CustomInputAccessoryViewDelegate: class {
    
    func inputView(_ inputView: CustomInputAccessoryView, wantsToSend message: String)
    
}

// this whole uiview creates the the textview on the chat were people write their messages

class CustomInputAccessoryView: UIView {
    
    
    //MARK: - PROPERTIES
    
    weak var delegate: CustomInputAccessoryViewDelegate?
    
     private lazy var messageInputTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        
        
        return tv
    }()
    
    
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.purple, for: .normal)
        button.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
        
        return button
    }()
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "enter Message"
        label.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        label.textColor = .lightGray
        return label
    }()
    
    
    
    //MARK: - LIFECYCLE
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        // gives it a custom height, if we dont do this then the text thingy will look different in each phone.
        autoresizingMask = .flexibleHeight
        
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 10
        layer.shadowOffset = .init(width: 0, height: -5)
        layer.shadowColor = UIColor.lightGray.cgColor
        
        
        addSubview(sendButton)
        sendButton.anchor(top: topAnchor, right: rightAnchor, paddingTop: 4, paddingRight: 8)
        sendButton.setDimensions(height: 50, width: 50)
        
        addSubview(messageInputTextView)
        messageInputTextView.anchor(top: topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: sendButton.leftAnchor, paddingTop: 12, paddingLeft: 4, paddingBottom: 8, paddingRight: 8)
        
        addSubview(placeholderLabel)
        placeholderLabel.anchor(left: messageInputTextView.leftAnchor, paddingLeft: 10)
        placeholderLabel.centerY(inView: messageInputTextView)
        
        
    NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange),
                                 name: UITextView.textDidChangeNotification, object: nil)
        
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    
    //MARK: - SELECTORS
    
    
    @objc func handleSendMessage() {
        
        guard let message = messageInputTextView.text else {return}
        delegate?.inputView(self, wantsToSend: message)
        
    }
    
    
    // hides the placeholder text the moment a user begins to type a message
    @objc func handleTextInputChange() {
        
        placeholderLabel.isHidden = !self.messageInputTextView.text.isEmpty
        
        
    }
    
    
    
    //MARK: - HELPERS
    
    func clearMessage() {
        
        messageInputTextView.text = nil
        placeholderLabel.isHidden = false
        
        
    }
    
    
    //MARK: - ACTION
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
