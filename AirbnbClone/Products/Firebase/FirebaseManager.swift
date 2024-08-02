//
//  FirebaseManager.swift
//  AirbnbClone
//
//  Created by Emre Simsek on 28.07.2024.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

struct FirebaseManager {

    private init() {}

    struct Authh {
        private init() {}
        static let instance = Auth.self
    }
    
    struct Fires {
        private init() {}
        static let instance = Firestore.firestore()
    }

}
