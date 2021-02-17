//
//  MatchCellViewModel.swift
//  TinderTutorial
//
//  Created by Stephen Dowless on 5/17/20.
//  Copyright © 2020 Stephan Dowless. All rights reserved.
//

import Foundation

struct MatchCellViewModel {
    
    let nameText: String
    var profileImageUrl: URL?
    let uid: String
        
    init(match: Match) {
        nameText = match.name
        profileImageUrl = URL(string: match.profileImageUrl)
        uid = match.uid
    }
}
