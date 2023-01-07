//
//  Profile.swift
//  FiveStars
//
//  Created by Yousuf Yesil on 15.12.22.
//

import SwiftUI


struct ProfileViews: View{
    
    var body: some View{
        
        VStack{
            HStack{
                CircleImage(image: Image("test"))
                    .frame(width: 140.0, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/)
                
                VStack{
                    Text("19")
                        .font(.callout)
                        .fontWeight(.medium)
                    Text("Freunde")
                        .fontWeight(.semibold)

                }
                .frame(width: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/)
                VStack{
                    Text("4.5 ")
                        .font(.callout)
                        .fontWeight(.medium)
                    
                    Text("Rating")
                        .fontWeight(.semibold)

                    
                }
                .frame(width: 52.0, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/)
            }
            .padding(.leading, -52.0)
            .offset(y: -290)
            VStack(alignment: .leading){
                
                HStack{
                    Text("Max")
                        .fontWeight(.semibold)
                    
                    Text("Mustermann")
                        .fontWeight(.semibold)
                    
                    
                }
                Text("Entwickler")
                    .font(.caption)
                    .fontWeight(.light)
                
            }
            .offset(y: -277)
            .padding(.leading, -165.0)
           Rectangle()
                .cornerRadius(15.0)
                .frame(width: 359.0, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/)
                .offset(y: -250)
                .foregroundColor(Color.green)

        }
        
        
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

