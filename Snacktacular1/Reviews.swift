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
    func loadData(spot: Spot, completed: @escaping () -> ()) {
        guard spot.documentID != "" else {
            return
        }
        db.collection("spots").document(spot.documentID).collection("reviews").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("Error: adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.reviewArray = []
            for document in querySnapshot!.documents {
            
                let review = Spot(dictionary: document.data())
                review.documentID = document.documentID
                self.reviewArray.append(review)
                // 17 min second to last video
            }
            completed()
        }
    }
}
