import SwiftUI

struct CircleImage: View {
    var image: Image

    var body: some View {
        image
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .overlay {
                Circle().stroke(.white, lineWidth: 2)
            }
            .shadow(radius: 7)
        
    }
}

struct Image_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("Test"))
    }
}
