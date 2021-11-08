//
//  Reviews.swift
//  Snacktacular1
//
//  Created by Christopher Rea on 11/8/21.
//

import Foundation
import Firebase

class Reviews {
    var reviewArray: [Review] = []
    
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
}
