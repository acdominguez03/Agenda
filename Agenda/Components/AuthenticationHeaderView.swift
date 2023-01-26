//
//  AuthenticationViewHeader.swift
//  Agenda
//
//  Created by Apps2T on 17/1/23.
//

import SwiftUI

struct AuthenticationHeaderView: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{Spacer()}
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            Text(subtitle)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
        .frame(height: 260)
        .padding(.leading)
        .background(Color("CustomColor"))
        .foregroundColor(.black)
        .clipShape(RoundedShape(corner: [.bottomRight]))
    }
}

struct AuthenticationHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationHeaderView(title: "Hello", subtitle: "Welcome Back")
    }
}

