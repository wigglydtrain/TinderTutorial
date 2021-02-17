//
//  Constants.swift
//  TinderTutorial
//
//  Created by Stephen Dowless on 5/4/20.
//  Copyright © 2020 Stephan Dowless. All rights reserved.
//

import Firebase

let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_SWIPES = Firestore.firestore().collection("swipes")
let COLLECTION_MATCHES_MESSAGES = Firestore.firestore().collection("matches_messages")
