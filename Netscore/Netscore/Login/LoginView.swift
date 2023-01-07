//
//  LoginView.swift
//  Netscore
//
//  Created by Yousuf Yesil on 17.12.22.
//

import SwiftUI
import PhotosUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

struct LoginView: View {
    //MARK: User Details
    @State var emailID: String = ""
    @State var password: String = ""
    
    // MARK: View properties
    @State var createAccount: Bool = false
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    @State var isLoading: Bool = false
    
    @AppStorage("log_status") var logStatus: Bool = false
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var userNameStored: String = ""
    @AppStorage("user_UID") var userUID: String = ""
    
    var body: some View {
        VStack(spacing: 10){
            Text("Willkommen bei NetScore")
                .font(.largeTitle.bold())
                .hAlign(.leading)
            
            VStack(spacing: 12) {
                TextField("Email", text: $emailID)
                    .textContentType(.emailAddress)
                    .border(1, .gray.opacity(0.5))
                    .padding(.top, 25)
                SecureField("Passwort", text: $password)
                    .textContentType(.emailAddress)
                    .border(1, .gray.opacity(0.5))
                Button("Passwort zurücksetzen", action: resetPassword)
                    .font(.callout)
                    .fontWeight(.medium)
                    .tint(.black)
                    .hAlign(.trailing)
                
                Button(action: loginUser) {
                    // MARK: Login Button
                    Text("Sign In")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .hAlign(.center)
                        .fillView(.black)
                }
                .padding(.top,10)
                
            }
            
            // MARK: Register Button
            HStack{
                
                Text("Noch nicht registriert?")
                    .foregroundColor(.gray)
                Button("Jetzt registrieren"){
                    createAccount.toggle()
                    
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
            LoadingView(show: $isLoading)        })
        //MARK: Register View VIA Sheets
        .fullScreenCover(isPresented: $createAccount) {
            RegisterView()
        }
        .alert(errorMessage, isPresented: $showError, actions: {})
    }
    func loginUser(){
        isLoading = true
        closeKeyboard()
        Task{
            do{
                try await Auth.auth().signIn(withEmail: emailID, password: password)
                print("User found")
                try await fetchUser()
            }catch{
                
                await setError(error)
            }
        }
    }
    
    func fetchUser()async throws{
        guard let userID = Auth.auth().currentUser?.uid else {return}
        let user = try await Firestore.firestore().collection("Users").document(userID).getDocument(as: User.self)
        await MainActor.run(body: {
            userUID = userID
            userNameStored = user.username
            profileURL = user.userProfileURL
            logStatus = true
        })
    }
    
    func resetPassword(){
        Task{
            do{
                try await Auth.auth().sendPasswordReset(withEmail: emailID)
                print("Versendet ^")
            }catch{
                
                await setError(error)
            }
        }
    }
    // MARK: Displaying Errors VIA Alert
    func setError(_ error: Error)async{
        // MARK: UI Must be Updated on Main Thread
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
            isLoading = false

        })
    }
}





//MARK: View Extensions for UI Buildung

