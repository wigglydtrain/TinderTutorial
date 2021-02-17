//
//  ConversationViewModel.swift
//  TinderFirestore
//
//  Created by Stephen Dowless on 4/27/20.
//  Copyright © 2020 Stephan Dowless. All rights reserved.
//

import Foundation

struct ConversationViewModel {
    
    private let conversation: Conversation
    
    var profileImageUrl: URL? {
        return URL(string: conversation.user.imageURLs.first!)
    }
    
    var messageText: String
    var usernameText: String
    
    var timestamp: String {
        let date = conversation.message.timestamp.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
    
    init(conversation: Conversation) {
        self.conversation = conversation
        
        messageText = conversation.message.text
        usernameText = conversation.user.name
    }
}
