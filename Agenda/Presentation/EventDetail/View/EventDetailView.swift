//
//  EventDetailView.swift
//  Agenda
//
//  Created by Apps2T on 27/1/23.
//

import SwiftUI

struct EventDetailView: View {
    var event: EventPresentationModel
    
    var body: some View {
        ZStack{
            VStack(spacing: 20){
                Spacer()
                
                AsyncImage(url: URL(string: "https://picsum.photos/200/300")){
                    image in
                    image.resizable()
                }placeholder: {
                    ProgressView()
                }
                .cornerRadius(50)
                .frame(width: 200, height: 200)
                .frame(maxWidth: UIScreen.main.bounds.width, alignment: .center)
                    
                
                Text(event.name)
                    .font(.system(size: 30))
                    .bold()
                
                Text(datetimeToString(date: event.date))
                    .font(.system(size: 25))
                
                Spacer()
            }
            .background(Color("Background"))
            .ignoresSafeArea()
        }
        
    }
}

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailView(event: EventPresentationModel(name: "Hola", date: 1234567892))
    }
}
