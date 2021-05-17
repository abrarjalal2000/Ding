//
//  SocialMedia.swift
//  Ding1
//
//  Created by adnan jalal on 5/16/21.
//

import Foundation
import Firebase

class SocialMedia {
    var name: String
    var user_name: String
    var platform: String
    var handle: String
    var numberOfHandles: Int
    var postingUserID: String
    var documentID: String

    var dictionary: [String: Any] {
           return ["name": name, "user_name": user_name, "platform": platform, "handle": handle, "numberOfHandles": numberOfHandles, "postingUserID": postingUserID]
       }

    init(name: String, user_name: String, platform: String, handle: String, numberOfHandles: Int,postingUserID: String, documentID: String) {
        self.name = name
        self.user_name = user_name
        self.platform = platform
        self.handle = handle
        self.numberOfHandles = numberOfHandles
        self.postingUserID = postingUserID
        self.documentID = documentID
    }

    convenience init() {
        self.init(name: "", user_name: "", platform: "", handle: "", numberOfHandles: 0, postingUserID: "", documentID: "")
    }

    convenience init(dictionary: [String: Any]) {
        let name = dictionary["name"] as! String? ?? ""
        let user_name = dictionary["user_name"] as! String? ?? ""
        let platform = dictionary["platform"] as! String? ?? ""
        let handle = dictionary["handle"] as! String? ?? ""
        let numberOfHandles = dictionary["numberOfHandles"] as! Int? ?? 0
        let postingUserID = dictionary["postingUserID"] as! String? ?? ""
        self.init(name: name, user_name: user_name, platform: platform, handle: handle, numberOfHandles: numberOfHandles, postingUserID: postingUserID, documentID: "")
    }


    func saveData(completion: @escaping (Bool) -> ()) {
           let db = Firestore.firestore()
           // Grab the user ID
           guard let postingUserID = Auth.auth().currentUser?.uid else {
               print("😡 ERROR: Could not save data because we dno't have a valid postingUserID.")
               return completion(false)
           }
           self.postingUserID = postingUserID
           // Create the dictionary representing data we want to save
           let dataToSave: [String: Any] = self.dictionary
           // if we HAVE saved a record, we'll have an ID, otherwise .addDocument will create one.
           if self.documentID == "" { // Create a new document via .addDocument
               var ref: DocumentReference? = nil // Firestore will create a new ID for us
               ref = db.collection("socialmedias").addDocument(data: dataToSave){ (error) in
                   guard error == nil else {
                       print("😡 ERROR: adding document \(error!.localizedDescription)")
                       return completion(false)
                   }
                   self.documentID = ref!.documentID
                   print("💨 Added document: \(self.documentID)") // It worked!
                   completion(true)
               }
           } else { // else save to the existing documentID w/.setData
               let ref = db.collection("socialmedias").document(self.documentID)
               ref.setData(dataToSave) { (error) in
                   guard error == nil else {
                       print("😡 ERROR: updating document \(error!.localizedDescription)")
                       return completion(false)
                   }
                   print("💨 Updated document: \(self.documentID)") // It worked!
                   completion(true)
               }
           }
       }

}
