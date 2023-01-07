//
//  ReusableProfileContent.swift
//  Netscore
//
//  Created by Yousuf Yesil on 18.12.22.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore

import SDWebImageSwiftUI
struct ReusableProfileContent: View {
    @State var isFetching: Bool = false


    var user: User
    @State private var fetchedPosts: [Post] = []
    @AppStorage("user_UID") private var  userUID: String = ""

    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            LazyVStack{
                HStack(spacing: 12){
                    WebImage(url: user.userProfileURL).placeholder{
                        Image("test")
                            .resizable()
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("\(user.username)")
                        
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text(user.userBio)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .lineLimit(3)
                        

                        
                        if let bioLink = URL(string: user.userBioLink){
                            Link(user.userBioLink, destination: bioLink)
                                .font(.callout)
                                .tint(.blue)
                                .lineLimit(1)
                            
                           // ProfileInteraction()

                        }
                    }
                    .hAlign(.leading)
                }
                Text("Posts")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .hAlign(.leading)
                    .padding(.vertical,15)
                
               // ResusablePostsView(basedOnUID: true,uid: user.userUID, posts: $fetchedPosts)
            }
           

            .padding(15)
        }
    }
 
  /*  @ViewBuilder
    func ProfileInteraction() ->some View{
        HStack(spacing: 6) {
            Button (action: ProfilelikePosts) {
                Image(systemName:user.ProfilelikedIDs.contains(userUID) ? "hand.thumbsup.fill" : "hand.thumbsup")
                    .bold()
            }
            
            Text("\(user.ProfilelikedIDs.count)")
                .bold()
                .font(.caption)
                .foregroundColor(.gray)
            Button (action: ProfiledislikePosts) {
                Image(systemName: user.ProfiledislikedIDs.contains(userUID) ? "hand.thumbsdown.fill" : "hand.thumbsdown")
                    .bold()

            }
            .padding(.leading,25)
            Text("\(user.ProfiledislikedIDs.count)")
                .bold()

                .font(.caption)
                .foregroundColor(.gray)
        }
        .foregroundColor(.black)
        .padding(.vertical,8)
    }
    func ProfilelikePosts(){
        Task{
            guard let postID = user.id else {return}
            if user.ProfilelikedIDs.contains(userUID){
                try await Firestore.firestore().collection("Users").document(postID).updateData([
                    "likedIDs": FieldValue.arrayRemove([userUID])
                ])
                
            }else {
                try await  Firestore.firestore().collection("Posts").document(postID).updateData([
                    "likedIDs": FieldValue.arrayUnion([userUID]),
                    "dislikedIDs": FieldValue.arrayRemove([userUID])
                ])
                
            }
        }
    }

    
    func ProfiledislikePosts(){
        Task{
            guard let postID = user.id else {return}
            if user.ProfiledislikedIDs.contains(userUID){
                try await  Firestore.firestore().collection("Posts").document(postID).updateData([
                    "dislikedIDs": FieldValue.arrayRemove([userUID])
                ])
                
            }else {
                try await Firestore.firestore().collection("Posts").document(postID).updateData([
                    "likedIDs": FieldValue.arrayRemove([userUID]),
                    "dislikedIDs": FieldValue.arrayUnion([userUID])
                ])
                
            }
        }
    }*/
}



struct ReProfileContent_Previews: PreviewProvider {
    static var previews: some View {
        ReusableProfileContent(user: User(username: "Test", userBio: "Test", userBioLink: "TestLink", userUID: "ID1", userEmail: "mail", userProfileURL: URL.applicationDirectory))
    }
}
