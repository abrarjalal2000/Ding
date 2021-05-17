//
//  SocialMedias.swift
//  Ding1
//
//  Created by adnan jalal on 5/16/21.
//

import Foundation
import Firebase

class SocialMedias {
    var socialMediaArray: [SocialMedia] = []
    var db: Firestore!

    init() {
        db = Firestore.firestore()
    }

    func loadData(completed: @escaping () -> ()) {
        db.collection("socialmedias").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("😡 ERROR: adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.socialMediaArray = [] // clean out existing spotArray since new data will load
            // there are querySnapshot!.documents.count documents in the snapshot
            for document in querySnapshot!.documents {
                // You'll have to maek sure you have a dictionary initializer in the singular class
                let socialMedia = SocialMedia(dictionary: document.data())
                socialMedia.documentID = document.documentID
                self.socialMediaArray.append(socialMedia)
            }
            completed()
        }
    }
}



