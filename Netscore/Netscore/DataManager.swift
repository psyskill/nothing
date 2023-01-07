//
//  DataManager.swift
//  Netscore
//
//  Created by Yousuf Yesil on 17.12.22.
//
import SwiftUI
import Firebase
import FirebaseDatabase
import FirebaseFirestore

struct Dog: Identifiable {
    var id: String
    var Lehrer: String
}



class DataManager: ObservableObject{
    @Published var lehrers: [Dog] = []
    
    init() {
        fetchDogs()
    }
    
    func fetchDogs(){
        lehrers.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Lehrer")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents{
                    let data = document.data()
                    
                    let id = data ["id"] as? String ?? ""
                    let Lehrer = data ["Lehrer"] as? String ?? ""
                    
                    let Lehrers = [Dog(id: id, Lehrer: Lehrer)]
                    self.lehrers.append(contentsOf: Lehrers)

                }
            }
        }
        
        
    }
}
