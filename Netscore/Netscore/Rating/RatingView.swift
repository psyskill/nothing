//
//  RatingView.swift
//  FiveStars
//
//  Created by Yousuf Yesil on 15.12.22.
//

import SwiftUI


struct RatingView: View{
    
    @State private var itemName: String = ""
    @State private var rating: Int = 0
    @State private var searchText = ""
    
    var body: some View{
        List(0..<4){
            
            message in
            RatingItem()
            
        }
        .searchable(text: $searchText)
        
    }
}

struct Previews_RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView()
        
        
    }
}


