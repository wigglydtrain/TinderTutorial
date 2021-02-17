//
//  Match.swift
//  TinderTutorial
//
//  Created by Stephen Dowless on 5/15/20.
//  Copyright © 2020 Stephan Dowless. All rights reserved.
//

import Foundation

struct Match {
    let name: String
    let profileImageUrl: String
    let uid: String
    
    init(dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
