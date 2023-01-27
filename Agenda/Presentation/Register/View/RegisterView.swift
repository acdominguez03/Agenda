//
//  RegisterView.swift
//  Agenda
//
//  Created by Apps2T on 17/1/23.
//

import SwiftUI

struct RegisterView: View {
    
    // MARK: - Variables
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var repeatPassword: String = ""
    @State private var showingFailedRegisterAlert: Bool = false
    @State private var showingFailedPasswords: Bool = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var viewModel: RegisterViewModel = RegisterViewModel()
    
    // MARK: - Body
    
    var body: some View {
        NavigationView{
            VStack{
                AuthenticationHeaderView(title: "What's up", subtitle: "Create your account")
                
                textFields
                
                signUpButton
                
                Spacer()
                
                goToSignIn
                
            }.ignoresSafeArea()
                .background(Color("Background"))
        }
    }
    
    //MARK: - Accessory Views
    var textFields: some View{
        VStack(spacing: 40){
            
            CustomTextField(imageName: "person", placeholderText: "Username", text: $username)
            
            CustomTextField(imageName: "lock",
                            placeholderText: "Password",
                            isSecureField: true,
                            text: $password)
            
            CustomTextField(imageName: "lock",
                            placeholderText: "Confirm Password",
                            isSecureField: true,
                            text: $repeatPassword)
        }
        .padding(32)
    }
    
    var signUpButton: some View{
        Button {
            if(password == repeatPassword){
                viewModel.register(user: username, pass: password) { statusCode in
                    if(statusCode != 200){
                        showingFailedRegisterAlert = true
                    }else{
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }else{
                showingFailedPasswords = true
            }
        } label: {
            Text("Sign Up")
                .font(.headline)
                .foregroundColor(.black)
                .frame(width: 340, height: 50)
                .background(Color("CustomColor"))
                .clipShape(Capsule())
                .padding()
        }
        .alert(isPresented: $showingFailedRegisterAlert) {
            showAlert(message: "Register failed")
        }
        .alert(isPresented: $showingFailedPasswords) {
            showAlert(message: "The passwords are different")
        }
    }
    
    var goToSignIn: some View{
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            HStack {
                Text("You have an account??")
                    .font(.footnote)
                
                Text("Sign In")
                    .font(.body)
                    .fontWeight(.semibold)
            }
        }
        .padding(.bottom, 32)
        .foregroundColor(Color.black)
    }
}


struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

func showAlert(message: String) -> Alert {
    return Alert(title: Text(message), dismissButton: .default(Text("Ok")))
}

