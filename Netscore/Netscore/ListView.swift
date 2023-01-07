//
//  ListView.swift
//  Netscore
//
//  Created by Yousuf Yesil on 17.12.22.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import SDWebImageSwiftUI

struct ListView: View {
    
    @State var userSearch = ""
    var body: some View {
        ScrollView{
            
            Rectangle()
                .cornerRadius(15.0)
                .frame(width: 360, height: 100)
                .foregroundColor(.blue)
            
        }
        .navigationTitle("Ratings")
        .searchable(text: $userSearch)

    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
