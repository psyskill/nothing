//
//  StartView.swift
//  Netscore
//
//  Created by Yousuf Yesil on 17.12.22.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        TabView {
              
              RatingView()
                  .tabItem {
                      Image(systemName: "1.circle")
                  }
              
              
              ProfileView()
                  .tabItem {
                      Image(systemName: "person.circle.fill")
                  }
            

          }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
