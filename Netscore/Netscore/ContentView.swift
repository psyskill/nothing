import SwiftUI
import Firebase
import FirebaseAuth


struct ContentView: View{
    @AppStorage("log_status") var logStatus: Bool = false

    var body: some View{
        if logStatus{
            MainView()
            
        } else {
            LoginView()
        }
        
    }
}
/*
 struct ContentView: View {
 @State private var email = ""
 @State private var password = ""
 @State private var userIsLoggedIn = false
 
 
 
 var body: some View {
 
 ZStack{
 Color.black
 
 RoundedRectangle(cornerRadius: 30, style: .continuous)
 .foregroundStyle(.linearGradient(colors: [.pink, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
 .frame(width: 1150, height: 450)
 .rotationEffect(.degrees(135))
 .offset(y: -350)
 
 VStack(spacing: 20){
 Text("Welcome")
 .foregroundColor(.white)
 .font(.system(size: 40, weight: .bold, design: .rounded))
 .offset(x: -100, y: -100)
 TextField("", text: $email)
 .foregroundColor(.white)
 .textFieldStyle(.plain)
 .placeholder(when: email.isEmpty) {
 Text("Email")
 .foregroundColor(.white)
 .fontWeight(.bold)
 }
 Rectangle()
 .frame(width: 350, height: 1)
 .foregroundColor(.white)
 
 SecureField("",text: $password)
 .foregroundColor(.white)
 .textFieldStyle(.plain)
 .placeholder(when: password.isEmpty) {
 Text("Password")
 .foregroundColor(.white)
 .fontWeight(.bold)
 }
 Rectangle()
 .frame(width: 350, height: 1)
 .foregroundColor(.white)
 
 Button {
 register()                } label: {
 Text("Sign Up")
 .fontWeight(.bold)
 .frame(width: 200, height: 40)
 .background(
 RoundedRectangle(cornerRadius: 10, style: .continuous)
 .fill(.linearGradient(Gradient(colors: [.pink, .red]), startPoint: .top, endPoint: .bottomTrailing))
 )
 .foregroundColor(.white)
 }
 .padding(.top)
 .offset(y: 100)
 Button {
 login()
 } label: {
 Text("Hast du bereits ein Konto? Einloggen")
 .fontWeight(.bold)
 .foregroundColor(.white)
 
 }
 .padding(.top)
 .offset(y: 110)
 }
 .frame(width: 350)
 .onAppear{
 Auth.auth().addStateDidChangeListener { auth, user in
 if user != nil {
 userIsLoggedIn.toggle()
 }
 }
 }
 }
 .ignoresSafeArea()
 }
 func login(){
 Auth.auth().signIn(withEmail: email, password: password) { result, error in
 if error != nil {
 print(error!.localizedDescription)
 }
 }
 }
 func register(){
 Auth.auth().createUser(withEmail: email, password: password) { result, error in
 if error != nil {
 print(error!.localizedDescription)
 }
 }
 }
 /*  TabView {
  
  RatingView()
  .tabItem {
  Image(systemName: "1.circle")
  }
  
  Start()
  .tabItem {
  Image(systemName: "person.circle.fill")
  }
  
  ProfileView()
  .tabItem {
  Image(systemName: "person.circle.fill")
  }
  Labor(content: "String")
  .tabItem {
  Image(systemName: "1.circle")
  }
  
  }
  
  */
 
 }
 
 
 extension View{
 func placeholder<Content: View>(
 when shouldShow: Bool,
 alignment: Alignment = .leading,
 @ViewBuilder placerholder: () -> Content) -> some View {
 ZStack(alignment: alignment) {
 placerholder().opacity(shouldShow ? 1 : 0)
 self
 }
 
 }
 }
 
 
 struct Previews_ContentView_Previews: PreviewProvider {
 static var previews: some View {
 ContentView()
 
 
 }
 }
 
 */
