//
//  EventsView.swift
//  Agenda
//
//  Created by Apps2T on 17/1/23.
//

import SwiftUI

struct EventsView: View {
    
    //MARK: Variables
    
    @ObservedObject var viewModel: ViewModel = ViewModel()
    @State private var showNewEventView: Bool = false
    
    //MARK: Body
    var body: some View {
        NavigationView{
            ZStack(alignment: .bottomTrailing){
                
                eventsList
                
                addButton
               
            }.navigationTitle(Text("Events"))
                .background(Color("Background"))
        }
        .onAppear{
            viewModel.getEvents()
        }
        .navigationBarHidden(true)
    }
    
    //MARK: - Accessory Views
    var eventsList: some View {
        ScrollView {
            LazyVStack(spacing: 1) {
                ForEach(viewModel.events) { event in
                    NavigationLink(destination: EventDetailView(event: event), label: {
                        HStack {
                            Text(event.name)
                            Spacer()
                            Text("\(datetimeToString(date: event.date))")
                        }
                        .padding(.horizontal, 5)
                        .frame(height: 40)
                        .background(Color.white)
                        .padding(.horizontal, 10)
                        .foregroundColor(.black)
                    })
                }
            }
        }
        .padding(.bottom, 5)
    }
    
    var addButton: some View {
        Button {
            self.showNewEventView.toggle()
        } label: {
            Image(systemName: "plus")
                .resizable()
                .renderingMode(.template)
                .frame(width: 20, height: 20)
                .padding()
        }
        .background(Color("CustomColor"))
        .foregroundColor(.white)
        .clipShape(Circle())
        .padding()
        .fullScreenCover(isPresented: $showNewEventView) {
            NewEventView(showNewEventView: $showNewEventView){
                viewModel.getEvents()
            }
        }
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView()
    }
}

//MARK: Function to pass datetime to string
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

