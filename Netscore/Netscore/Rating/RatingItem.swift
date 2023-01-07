

import SwiftUI

struct RatingItem: View{
    
    @State private var itemName: String = ""
    @State private var rating: Int = 0

    var body: some View{
        VStack {
            TextField("Person", text: $itemName)
            HStack {
                ForEach(1..<6) { number in
                    Image(systemName: number > self.rating ? "star" : "star.fill")
                        .foregroundColor(.yellow)
                        .onTapGesture {
                            self.rating = number
                        }
                }
            }
            

            Button(action: {
                // Save the item and rating to a database or array here
            }) {
                Text("Save Rating")
            }
        }

    }
}

struct Previews_RatingItem_Previews: PreviewProvider {
    static var previews: some View {
        RatingItem()
        
        
    }
}

