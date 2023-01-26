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
    @State private var showingAlert: Bool = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let authViewModel = AuthenticationViewModel()
    
    // MARK: - Body
    
    var body: some View {
        NavigationView{
            VStack{
                AuthenticationHeaderView(title: "What's up", subtitle: "Create your account")
                
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
                
                Button {
                    if(password == repeatPassword){
                        authViewModel.register(user: username, pass: password)
                        presentationMode.wrappedValue.dismiss()
                    }else{
                        showingAlert = true
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
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("The passwords are different"), dismissButton: .default(Text("Ok")))
                }
                Spacer()
                
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
                
                
                
            }.ignoresSafeArea()
                .background(Color("Background"))
        }
    }
}


struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
