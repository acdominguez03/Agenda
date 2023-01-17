//
//  LoginView.swift
//  Agenda
//
//  Created by Apps2T on 17/1/23.
//
import SwiftUI

struct LoginView: View {
    @State private var user = ""
    @State private var password = ""
    @State private var showingAlert: Bool = false
    @State private var validLogin: Bool = false
    let authenticationViewModel = AuthenticationViewModel()
    
    var body: some View {
        NavigationView{
            VStack {
                //header view
                AuthenticationHeaderView(title: "You Men,", subtitle: "What's Up?")
                
                VStack(spacing: 40) {
                    CustomTextField(imageName: "person", placeholderText: "Username", text: $user)
                    
                    CustomTextField(imageName: "lock",
                                    placeholderText: "Password",
                                    isSecureField: true,
                                    text: $password)
                }
                .padding(.horizontal, 32)
                .padding(.top, 44)
                
                HStack {
                    Spacer()
                    NavigationLink {
                        Text("Reset Password view...")
                    } label: {
                        Text("Forgot Password?")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                            .padding(.top)
                            .padding(.trailing, 24)
                    }
                }
                
                Button {
                    authenticationViewModel.login(user: user, pass: password) { statusCode in
                        if(statusCode == 401){
                            showingAlert = true
                        }else{
                            validLogin = true
                        }
                    }
                } label: {
                    Text("Sign in")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(width: 340, height: 50)
                        .background(Color("CustomColor"))
                        .clipShape(Capsule())
                        .padding()
                }.alert(isPresented: $showingAlert) {
                    Alert(title: Text("The login failed"), dismissButton: .default(Text("Ok")))
                }
                
                Spacer()
                
                NavigationLink {
                    RegisterView()
                        .navigationBarHidden(true)
                } label: {
                    HStack {
                        Text("Don't have an account?")
                            .font(.footnote)
                        
                        Text("Sign Up")
                            .font(.body)
                            .fontWeight(.semibold)
                    }
                }
                .padding(.bottom, 32)
                .foregroundColor(Color.black)
                .navigationBarHidden(true)
                
                NavigationLink(destination: EventsView() ,isActive: $validLogin) {
                    EmptyView()
                }
            }
            .background(Color("Background"))
            .ignoresSafeArea()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

