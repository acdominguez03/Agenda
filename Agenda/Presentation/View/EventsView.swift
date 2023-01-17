//
//  EventsView.swift
//  Agenda
//
//  Created by Apps2T on 17/1/23.
//

import SwiftUI

struct EventsView: View {
    
    @ObservedObject var eventViewModel = EventViewModel()
    @State private var events: [Event?] = []
    @State private var showNewEventView: Bool = false
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .bottomTrailing){
                List{
                    ForEach(eventViewModel.events, id: \.?.name) { event in
                        HStack{
                            if(event == nil){
                                Text("Evento no encontrado")
                                    .font(.system(size: 15))
                                    .foregroundColor(.black)
                            }else{
                                Text("\(event?.name ?? "")")
                                    .font(.system(size: 15))
                                    .foregroundColor(.black)
                                Spacer()

                                Text("\(datetimeToString(date: (event?.date) ?? 0))")
                                    .font(.system(size: 15))
                                    .foregroundColor(.black)
                                
                            }
                        }
                    }
                }
                .task({
                    eventViewModel.getEvents()
                })
                .listStyle(InsetGroupedListStyle())
            
                
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
                    NewEventView(events: $events)
                }
            
            }.navigationTitle(Text("Events"))
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
    let date = Date(timeIntervalSince1970: Double(date) / 1000.0)
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT +1")
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    let strDate = dateFormatter.string(from: date)
    return strDate
}

