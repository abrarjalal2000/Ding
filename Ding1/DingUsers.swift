//
//  DingUsers.swift
//  Ding1
//
//  Created by adnan jalal on 5/16/21.
//

import Foundation
import Firebase

class DingUsers {
    var dingUsersArray: [DingUser] = []
    var db: Firestore!

    init() {
        db = Firestore.firestore()
    }

    func loadData(completed: @escaping () -> ()) {
        db.collection("users").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("😡 ERROR: adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.dingUsersArray = [] // clean out existing spotArray since new data will load
            // there are querySnapshot!.documents.count documents in the snapshot
            for document in querySnapshot!.documents {
                // You'll have to maek sure you have a dictionary initializer in the singular class
                let dingUser = DingUser(dictionary: document.data())
                dingUser.documentID = document.documentID
                self.dingUsersArray.append(dingUser)
            }
            completed()
        }
    }
}

