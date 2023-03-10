//
//  PostsView.swift
//  Netscore
//
//  Created by Yousuf Yesil on 26.12.22.
//

import SwiftUI

struct PostsView: View {
    @State private var createNewPost: Bool = false
    @State private var recentPosts: [Post] = []
    
    var body: some View {
        NavigationStack{
            ResusablePostsView(posts: $recentPosts)
                .hAlign(.center).vAlign(.center)
                .overlay(alignment: .bottomTrailing) {
                    Button {
                        createNewPost.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(13)
                            .background(.black,in: Circle())
                    }
                    .padding(15)
                }
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            SearchUserView()
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .tint(.black)
                                .scaleEffect(0.9)
                        }

                    }
                })
                .navigationTitle("Beiträge")
        }
        .fullScreenCover(isPresented: $createNewPost) {
            CreateNewPost{ post in
                recentPosts.insert(post, at: 0)
            }
        }
    }
}

struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
    }
}
