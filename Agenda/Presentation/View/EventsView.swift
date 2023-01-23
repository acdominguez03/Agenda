//
//  EventsView.swift
//  Agenda
//
//  Created by Apps2T on 17/1/23.
//

import SwiftUI

struct EventsView: View {
    
    @ObservedObject var eventViewModel = EventViewModel()
    @State private var showNewEventView: Bool = false
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .bottomTrailing){
                ScrollView {
                    LazyVStack(spacing: 1) {
                        ForEach(eventViewModel.events) { event in
                            HStack {
                                Text(event.name)
                                Spacer()
                                Text("\(datetimeToString(date: event.date))")
                            }
                            .padding(.horizontal, 5)
                            .frame(height: 40)
                            .background(Color.white)
                            .padding(.horizontal, 10)
                        }
                    }
                }
                .padding(.bottom, 5)
                
                Button {
                    self.showNewEventView.toggle()
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 20, height: 20)
                        .padding()
                }
                .background(Color(.systemBlue))
                .foregroundColor(.white)
                .clipShape(Circle())
                .padding()
                .fullScreenCover(isPresented: $showNewEventView) {
                    NewEventView(showNewEventView: $showNewEventView){
                        eventViewModel.getEvents()
                    }
                }
            
            }.navigationTitle(Text("Events"))
        }
        .onAppear{
            eventViewModel.getEvents()
        }
        
        .navigationBarHidden(true)
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView()
    }
}

func datetimeToString(date: Int)-> String{
    var finalDate: Date = Date()
    if(String(date).count == 10){
        finalDate = Date(timeIntervalSince1970: Double(date))
    }else{
        finalDate = Date(timeIntervalSince1970: Double(date) / 1000.0)
    }
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT +1")
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    let strDate = dateFormatter.string(from: finalDate)
    return strDate
}

