//
//  User.swift
//  Netscore
//
//  Created by Yousuf Yesil on 18.12.22.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift


struct User: Identifiable,Codable {
    @DocumentID var id: String?
    var username: String
    var userBio: String
    var userBioLink: String
    var userUID: String
    var userEmail: String
    var userProfileURL: URL
   // var ProfilelikedIDs: [String] = []
   // var ProfiledislikedIDs: [String] = []


    enum CodingKeys: CodingKey{
        case id
        case username
        case userBio
        case userBioLink
        case userUID
        case userEmail
        case userProfileURL
      //  case ProfilelikedIDs
      //  case ProfiledislikedIDs


    }
    
    
    
}

