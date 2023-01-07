//
//  MainView.swift
//  Netscore
//
//  Created by Yousuf Yesil on 18.12.22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            PostsView()
                .tabItem {
                    Image(systemName: "rectangle.portrait.on.rectangle.portrait.angled")
                    Text("Ratings")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Profil")
                }
        }
        .tint(.black)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
