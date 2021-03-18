//
//  MessageModel.swift
//  ikastagram
//
//  Created by Devonly on 3/18/21.
//

import Foundation
import Firebase

struct MessageData: Identifiable {
    var id: String
    var uid: String
    var name: String
    var message: String
    var date: Date
}

class MessageViewModel: ObservableObject {
    @Published var messages = [MessageData]()
    private let dateFormatter = ISO8601DateFormatter()
    
    init() {
        let db = Firestore.firestore()
        dateFormatter.timeZone = TimeZone.current
        
        db.collection("messages").addSnapshotListener { (snap, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let snap = snap {
                for i in snap.documentChanges {
                    if i.type == .added {
                        let uid = i.document.get("uid") as! String
                        let name = i.document.get("name") as! String
                        let message = i.document.get("message") as! String
                        let date = self.dateFormatter.date(from: (i.document.get("date") as! String))!
                        let id = i.document.documentID

                        self.messages.append(MessageData(id: id, uid: uid, name: name, message: message, date: date))
                    }
                }
            }
        }
    }
    
    func send(message: String, user: String, uid: String) {
        let data = [
            "message": message,
            "name": user,
            "uid": uid,
            "date": dateFormatter.string(from: Date())
        ]
        
        let db = Firestore.firestore()
        
        db.collection("messages").addDocument(data: data) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("success")
        }
    }
    
}
