//
//  RegisterView.swift
//  Netscore
//
//  Created by Yousuf Yesil on 18.12.22.
//

import SwiftUI
import PhotosUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
// MARK: Register View

struct RegisterView: View{
    
    //MARK: User Details
    @State var emailID: String = ""
    @State var password: String = ""
    @State var userName: String = ""
    @State var userBio: String = ""
    @State var userBioLink: String = ""
    @State var userProfilePicData: Data?
    
    
    // MARK: View properties
    @Environment(\.dismiss) var dismiss
    @State var showImagePicker: Bool = false
    @State var photoItem: PhotosPickerItem?
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    @State var isLoading: Bool = false
    
    //MARK: UserDefaults
    
    @AppStorage("log_status") var logStatus: Bool = false
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var userNameStored: String = ""
    @AppStorage("user_UID") var userUID: String = ""
    
    var body: some View{
        VStack(spacing: 10){
            Text("Willkommen bei NetScore")
                .font(.largeTitle.bold())
                .hAlign(.leading)
            
            // MARK: For smaller size Optimization
            ViewThatFits{
                ScrollView(.vertical, showsIndicators: false){
                    HelperView()
                }
                HelperView()
            }
            
            // MARK: Register Button
            HStack{
                
                Text("Hast du schon ein Account?")
                    .foregroundColor(.gray)
                Button("Jetzt anmelden"){
                    dismiss()
                    
                }
                .fontWeight(.bold)
                .foregroundColor(.black)
            }
            .font(.callout)
            .vAlign(.bottom)
        }
        .vAlign(.top)
        .padding(15)
        .overlay(content: {
            LoadingView(show: $isLoading)
        })
        .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
        .onChange(of: photoItem) { newValue in
            // MARK: Extracting UIImage From PhotoItem
            
            if let newValue{
                Task{
                    do{
                        guard     let imageData = try await newValue.loadTransferable(type:
                                                                                        Data.self) else {return}
                        
                        await MainActor.run(body: {
                            userProfilePicData = imageData
                        })
                    }catch{}
                }
            }
            
        }
        //MARK: Displaying Alert:
        .alert(errorMessage, isPresented: $showError, actions: {})
    }
    @ViewBuilder
    func HelperView() -> some View{
        VStack(spacing: 12) {
            ZStack{
                if let userProfilePicData, let image = UIImage(data: userProfilePicData){
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else {
                    Image("test")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
            .frame(width: 85, height: 85)
            .clipShape(Circle())
            .contentShape(Circle())
            .onTapGesture {
                showImagePicker.toggle()
            }
            .padding(.top, 25)
            
            
            
            TextField("Benutzername", text: $userName)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))
                .padding(.top, 25)
            
            TextField("Email", text: $emailID)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))
            
            SecureField("Passwort", text: $password)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))
            
            
            
            TextField("Über dich", text: $userBioLink, axis: .vertical)
                .frame(minHeight: 100, alignment: .top)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))
            TextField("Links (Optional)", text: $userBio)
                .textContentType(.emailAddress)
                .border(1, .gray.opacity(0.5))
            
            
            
            
            
            
            
            Button(action: registerUser) {
                // MARK: Login Button
                Text("Account erstellen")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .hAlign(.center)
                    .fillView(.black)
            }
            .disableWithOpacity(userName == "" || emailID == "" || userProfilePicData == nil || password == "")
            .padding(.top,10)
            
        }
        
    }
    func registerUser(){
        isLoading = true
        closeKeyboard()
        Task{
            do{
                //MARK: Step 1: Creating User Firebase Account
                try await Auth.auth().createUser(withEmail: emailID, password: password)
                //MARK: Step 2: Profil Foto
                
                guard let UserUID = Auth.auth().currentUser?.uid else {return}
                guard let imageData = userProfilePicData else{return}
                let storageRef = Storage.storage().reference().child("Profile_Images").child(UserUID)
                let _ = try await storageRef.putDataAsync(imageData)
                // Step 3
                let downloadURL = try await storageRef.downloadURL()
                // Step 4
                let user = User(username: userName, userBio: userBio, userBioLink: userBioLink, userUID: UserUID, userEmail: emailID, userProfileURL: downloadURL)
                //Step 5
                let _ = try Firestore.firestore().collection("Users").document(UserUID).setData(from: user, completion: {
                    error in
                    if error == nil{
                        print("Erfolgreich gespeichert")
                        userNameStored = userName
                        self.userUID = UserUID
                        profileURL = downloadURL
                        logStatus = true
                    }
                })
            } catch {
                await setError(error)
                
            }
        }
    }
    //MARK: Displaying Errors via alert
    func setError(_ error: Error)async{
        // MARK: UI Must be Updated on Main Thread
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
            isLoading = false
        })
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
