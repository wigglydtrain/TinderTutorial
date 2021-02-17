//
//  ChatViewModel.swift
//  TinderFirestore
//
//  Created by Stephen Dowless on 2/29/20.
//  Copyright © 2020 Stephan Dowless. All rights reserved.
//

import UIKit

struct ChatViewModel {
    
    private let message: Message
    
    var messageBackgroundColor: UIColor {
        return message.isFromCurrentUser ? #colorLiteral(red: 0.1471898854, green: 0.8059007525, blue: 0.9965714812, alpha: 1) : #colorLiteral(red: 0.9005706906, green: 0.9012550712, blue: 0.9006766677, alpha: 1)
    }
    
    var messageTextColor: UIColor {
        return message.isFromCurrentUser ? .white : .black
    }
    
    var rightAnchorActive: Bool {
        return message.isFromCurrentUser
    }
    
    var leftAnchorActive: Bool {
        return !message.isFromCurrentUser
    }
    
    let messageText: String
    
    init(message: Message) {
        self.message = message
        
        messageText = message.text
    }
    
}
